``` python

@deprecate_nonkeyword_arguments(allowed_args=["io", "sheet_name"], version="2.0")
@Appender(_read_excel_doc)
def read_excel(
    io,
    sheet_name: str | int | list[IntStrT] | None = 0,
    header: int | Sequence[int] | None = 0, # 表示用第几行作为表头，默认header=0，即默认第一行为表头
    names=None,
    index_col: int | Sequence[int] | None = None,
    usecols=None,
    squeeze: bool | None = None,
    dtype: DtypeArg | None = None,
    engine: Literal["xlrd", "openpyxl", "odf", "pyxlsb"] | None = None,
    converters=None,
    true_values: Iterable[Hashable] | None = None,
    false_values: Iterable[Hashable] | None = None,
    skiprows: Sequence[int] | int | Callable[[int], object] | None = None,
    nrows: int | None = None,
    na_values=None,
    keep_default_na: bool = True,
    na_filter: bool = True,
    verbose: bool = False,
    parse_dates=False,
    date_parser=None,
    thousands: str | None = None,
    decimal: str = ".",
    comment: str | None = None,
    skipfooter: int = 0,
    convert_float: bool | None = None,
    mangle_dupe_cols: bool = True,
    storage_options: StorageOptions = None,
) -> DataFrame | dict[IntStrT, DataFrame]:
```

