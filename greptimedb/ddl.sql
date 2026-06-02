CREATE TABLE bluesky (
    "data" JSON2,
    time_us TimestampMicrosecond TIME INDEX
) WITH (
    'append_mode' = 'true',
    'sst_format' = 'flat'
)
