/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT '#' || t1.tag as tag, count(*) as count 
FROM (
    SELECT jsonb_path_query(data,'$.entities.hashtags[*]')->>'text' as tag,
        data->>'id'
    FROM tweets_jsonb
    WHERE
        data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
    UNION
    SELECT jsonb_path_query(data,'$.extended_tweet.entities.hashtags[*]')->>'text' as tag,
        data->>'id'
    FROM tweets_jsonb
    WHERE
        data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) t1
GROUP BY (tag)
ORDER BY count DESC,tag
LIMIT 1000;
