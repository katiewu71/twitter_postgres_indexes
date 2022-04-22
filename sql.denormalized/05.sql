/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */
SELECT '#' || t1.tag as tag, count(*) as count
FROM (
   SELECT jsonb_path_query(data,'$.entities.hashtags[*]')->>'text' as tag,
        data->>'id'
    FROM tweets_jsonb
    WHERE
        --ADD CLAUSE HERE to match text
        (to_tsvector('english',data->'text') @@ to_tsquery('english','coronavirus')
    OR to_tsvector('english',data->'extended_tweet'->>'full_text') @@ to_tsquery('english','coronavirus'))
        AND data->>'lang' = 'en'
    UNION
    SELECT jsonb_path_query(data,'$.extended_tweet.entities.hashtags[*]')->>'text' as tag,
        data->>'id'
    FROM tweets_jsonb
    WHERE
        --ADD CLAUSE HERE to match text
        (to_tsvector('english',data->'text') @@ to_tsquery('english','coronavirus')
    OR to_tsvector('english',data->'extended_tweet'->>'full_text') @@ to_tsquery('english','coronavirus'))
        AND data->>'lang' = 'en' 
) t1 
GROUP BY tag
ORDER BY count DESC,tag
LIMIT 1000
;

