using DEK.SQL.Client;
using POS.FindItemDtoLibrary.Data.FindItem;

namespace POS.API_Find_Item.Services
{
    public class FindItemService
    {
        private readonly DEKConnectionPool _poolPodnik = DEKConnectionPools.GetOrCreateById("STAVEBNINY_DEK");

        public HashSet<FindItem> FindItemsFromPrompt(string prompt, int limit)
        {
            HashSet<FindItem> items = new HashSet<FindItem>();

            using (DEKConnection connection = _poolPodnik.Get())
            {
                using (DEKQuery query = connection.CreateQuery())
                {
					string[] prompts = prompt.Split(' ');
					string innerQuery = @" select top (@limit) CPV.ID_ZAZNAMU
                                             from dbo.CZ_POLOZKA_VYHLEDAVANI as CPV
                                            where 1 = 1 ";
					string lastWord = string.Empty;
					for (int i = 0; i < prompts.Length; i++)
					{
						query.CommandText += @$" declare @L_HLEDANY_TEXT_{i} varchar(500)
                                                 select @L_HLEDANY_TEXT_{i} = @hledanyText{i} collate SQL_Czech_CP1250_CI_AS ";
						innerQuery += @$" and charindex(@L_HLEDANY_TEXT_{i}, CPV.PROHLEDAT + ' ' + CPV.OBLIBENE) > 0 ";
						lastWord = @$" , charindex(@L_HLEDANY_TEXT_{i}, CPV.PROHLEDAT) asc ";

					}
					innerQuery += @$"  and (CPV.NEAKTIVNI is null or CPV.NEAKTIVNI = 0)
                                     order by ( case when charindex(@L_CELY_TEXT, CPV.PROHLEDAT) = 0
                                                     then 999999999
                                                else charindex(@L_CELY_TEXT, CPV.PROHLEDAT)
                                                end) asc
                                              {lastWord}
                                              , case when +charindex(';P100;', isnull(CPV.OBLIBENE, '')) > 0
                                                     then 2
                                                     when +charindex(';P100*;', isnull(CPV.OBLIBENE, '')) > 0
                                                     then 1
                                                     when +charindex(';P100*;', isnull(CPV.OBLIBENE, '')) + charindex(';P100+;', isnull(CPV.OBLIBENE, '')) > 0
                                                     then 3
                                                else 0
                                                end desc
                                              , CPV.ZOBRAZENI_1 ";

					query.CommandText += @$" declare @L_CELY_TEXT varchar(500)
                                              select @L_CELY_TEXT = @celyText collate SQL_Czech_CP1250_CI_AS

                                              
					                          select HDR.POL_INT                       as [identifiers.id]
                                                   , HDR.ID_POLOZKY                    as [identifiers.number]
                                                   , isnull(trim(PKN.ESHOP_NAZEV), '') as [name.long]
                                                   , trim(CPN.NAZEV_POLOZKY_KRATKY)    as [name.short]
                                                   , isnull(CPO.CRC_OBRAZKU, 0)        as [imagePrimary.crc]
                                                from ( {innerQuery} ) as TAB
                                               inner join dbo.CZ_POLOZKA_HDR        as HDR on HDR.ID_POLOZKY    = TAB.ID_ZAZNAMU
                                               inner join dbo.CZ_POLOZKA_NAZEV      as CPN on CPN.POL_INT       = HDR.POL_INT
                                                left join dbo.POLOZKA_KATALOG_NAZVY as PKN on PKN.POL_INT       = HDR.POL_INT
                                                left join dbo.CZ_POLOZKA_OBRAZKY    as CPO on CPO.CISLO_POLOZKY = TAB.ID_ZAZNAMU
                                              option (use hint ('ENABLE_PARALLEL_PLAN_PREFERENCE')) ";
					query.SetParameter("limit", limit);
					query.SetParameter("celyText", prompt);
					for (int i = 0; i < prompts.Length; i++)
					{
						query.SetParameter($"hledanyText{i}", prompts[i]);
					}
                    query.Open();

                    while (!query.EoF)
                    {
                        int crc = query.GetInt32("imagePrimary.crc");
                        items.Add(new FindItem
                        {
                            Identifier = new FindItemIdentifier
                            {
                                Id = query.GetInt32("identifiers.id"),
                                Number = query.GetString("identifiers.number")
                            },
                            ImagePrimary = new FindItemImagePrimary
                            {
                                Crc = crc,
                                Url = crc == 0 ? "" : $"https://cdn1.idek.cz/dek/img/product/{crc}_ew;Width;_eh;Height;.webp"
                            },
                            Name = new FindItemName
                            {
                                Long = query.GetString("name.long"),
                                Short = query.GetString("name.short")
                            }
                        });

                        query.Next();
                    }
                }
            }

            return items;
        }

        public HashSet<FindItem> GetItems(int limit)
        {
            HashSet<FindItem> items = new HashSet<FindItem>();

            using (DEKConnection connection = _poolPodnik.Get())
            {
                using (DEKQuery query = connection.CreateQuery())
                {
                    query.CommandText = @" select top (@limit)
                                                  HDR.POL_INT                       as [identifiers.id]
                                                            , HDR.ID_POLOZKY                    as [identifiers.number]
                                                , isnull(trim(PKN.ESHOP_NAZEV), '') as [name.long]
                                                , trim(CPN.NAZEV_POLOZKY_KRATKY)    as [name.short]
                                                , isnull(CPO.CRC_OBRAZKU, 0)                    as [imagePrimary.crc]
                                             from dbo.CZ_POLOZKA_HDR        as HDR
                                       inner join dbo.CZ_POLOZKA_NAZEV      as CPN on CPN.POL_INT       = HDR.POL_INT
                                        left join dbo.POLOZKA_KATALOG_NAZVY as PKN on PKN.POL_INT       = HDR.POL_INT
                                        left join dbo.CZ_POLOZKA_OBRAZKY    as CPO on CPO.CISLO_POLOZKY = HDR.ID_POLOZKY ";
                    query.SetParameter("limit", limit);
                    query.Open();

                    while (!query.EoF)
                    {
                        int crc = query.GetInt32("imagePrimary.crc");
                        items.Add(new FindItem
                        {
                            Identifier = new FindItemIdentifier
                            {
                                Id = query.GetInt32("identifiers.id"),
                                Number = query.GetString("identifiers.number")
                            },
                            ImagePrimary = new FindItemImagePrimary
                            {
                                Crc = crc,
                                Url = crc == 0 ? "" : $"https://cdn1.idek.cz/dek/img/product/{crc}_ew;Width;_eh;Height;.webp"
                            },
                            Name = new FindItemName
                            {
                                Long = query.GetString("name.long"),
                                Short = query.GetString("name.short")
                            }
                        });

                        query.Next();
                    }
                }
            }

            return items;
        }
    }
}

