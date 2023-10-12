#! /usr/bin/env python3

import sqlparse
import sys

contents = sys.stdin.read()

result = sqlparse.format(contents,
                         indent_columns=True,
                         keyword_case="lower",
                         identifier_case="upper",
                         reindent=True,
                         output_format="sql",
                         indent_after_first=True,
                         wrap_after=100,
                         comma_first=True
)

print(result.strip())
