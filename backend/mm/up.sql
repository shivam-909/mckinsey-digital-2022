CREATE TABLE household (
    id UUID PRIMARY KEY,
    postcode text
);

CREATE TABLE inhabitant (
    id UUID PRIMARY KEY,
    household_id UUID,
    weight_kg int,
    sex text,
    age_range text,
    passcode_hash text
);

CREATE TABLE food_item (
    id UUID PRIMARY KEY,
    household_id UUID,
    short_name text,
    food_description text,
    best_by timestamp
);

CREATE TABLE appliance (
    id UUID PRIMARY KEY,
    household_id UUID,
    appliance_type int
);

CREATE TABLE dietary_requirement (
    id UUID PRIMARY KEY,
    household_id UUID,
    requirement_type int
);

CREATE TABLE donation_center (
    id UUID PRIMARY KEY,
    trade_name text,
    street_address text
);