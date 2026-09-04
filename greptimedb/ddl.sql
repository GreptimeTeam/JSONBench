CREATE TABLE bluesky (
    "data" JSON2 (
        max_auto_expanded_paths = 0,
        kind String,
        commit.operation String,
        commit.collection String,
        did String,
        time_us Int64,
    ),
    time_us TimestampMicrosecond TIME INDEX
) WITH (
    'compaction.type' = 'twcs',
    'compaction.twcs.trigger_file_num' = '100000000',
    'append_mode' = 'true',
    'sst_format' = 'flat'
)
