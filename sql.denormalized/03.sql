/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */
SELECT t1.lang, count(*) as count
FROM (
    SELECT data->>'id',
        data->>'lang' as lang
    FROM tweets_jsonb
    WHERE
        data->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
    UNION
    SELECT data->>'id',
        data->>'lang' as lang
    FROM tweets_jsonb
    WHERE
        data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) t1
GROUP BY (t1.lang)
ORDER BY count DESC,t1.lang;


