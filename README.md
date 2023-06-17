# Extract PlateID Well Date operator

##### Description

`Extract PlateID Well Date` from a character column into multiple columns with a regular expression

##### Usage

Input projection|.
---|---
`row`        | single character column

Output relations|.
---|---
`col1`          | numeric or character
`col2`          | numeric or character
`etc..`          | multiple columns

##### Details

Given a regular expression , `Extract PlateID Well Date` turns a single character column into multiple columns.

##### References

This operator is a wrapper of the [strsplit R function](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strsplit).

##### See Also

[separate_operator](https://github.com/tercen/replace_operator)
