--  btree indexes
create index on tweet_tags(tag, id_tweets);
create index on tweet_tags(id_tweets, tag);
create index on tweets(id_tweets);
create index on tweets(lang);
-- gin index
create index on tweets using gin(to_tsvector('english',text));
