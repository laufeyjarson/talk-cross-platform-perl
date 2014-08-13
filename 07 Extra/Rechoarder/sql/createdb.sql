/* psql -U demo_app_user -f createdb.sql */
/* drop everything, in order */

drop table user_role;
drop table roles;
drop table users;

drop table catalog_pictures;

drop table catalog;
drop table media_types;
drop table listing_types;

drop table labels;
drop table artists;
drop table categories;
drop table conditions;
drop table mono_stereo_types;
drop table pictures;

drop table sessions;

/* mono_stereo_types - define a table to hold valid values for the
   mono_stereo column.  Use nice whole words. */

create table mono_stereo_types (
	id		serial,
	display_order	int not null,
	name		varchar(6) not null,

primary key(id)
);
comment on table mono_stereo_types is 'Define the valid names for the mono_stereo column.';

insert into mono_stereo_types values (DEFAULT, 1, 'Mono');
insert into mono_stereo_types values (DEFAULT, 2, 'Stereo');

/* Define the pictures table.  Each picture is associated with an album.  */

create table pictures (
	id		serial,
	cache_name	varchar(128) not null,
	comment		varchar(128),

primary key(id)
);
comment on table pictures is 'Stores information about where in the pictures cache are on the filesystem.';

/* Define the labels table, which holds the record label information.  */

create table labels (
	id		serial,
	name		varchar(40) not null,

primary key(id)
);
comment on table labels is 'Store the list of valid record labels.';

insert into labels values (DEFAULT, 'Unspecified');


/* Define the table of listing types. */

create table listing_types (
	id		int not null,	/* fixed values from GEMM! */
	name		varchar(40) not null,

primary key(id)
);
comment on table listing_types is 'Store the valid types of listing on GEMM.';

insert into listing_types values (3757, 'Music');
insert into listing_types values (3737, 'Books, Magazines, & Comics');
insert into listing_types values (3756, 'Movies & Videos');
insert into listing_types values (3731, 'Alternative Energy');
insert into listing_types values (3732, 'Antiques');
insert into listing_types values (3733, 'Art');
insert into listing_types values (3734, 'Auto, Motorcycle, & ATV');
insert into listing_types values (3735, 'Baby');
insert into listing_types values (3736, 'Beauty');
insert into listing_types values (3738, 'Business & Industrial');
insert into listing_types values (3739, 'Cameras & Photography');
insert into listing_types values (3740, 'Cell Phones & Accessories');
insert into listing_types values (3741, 'Clothing, Shoes & Accessories');
insert into listing_types values (3742, 'Coins & Paper Money');
insert into listing_types values (3743, 'Computers & Networking');
insert into listing_types values (3744, 'Consumer Electronics');
insert into listing_types values (3745, 'Crafts & Handmade');
insert into listing_types values (3746, 'Dolls & Bears');
insert into listing_types values (3747, 'Gift Cards & Coupons');
insert into listing_types values (3748, 'Gourmet Foods & Groceries');
insert into listing_types values (3749, 'Health, Beauty & Personal Care');
insert into listing_types values (3750, 'Home & Garden');
insert into listing_types values (3751, 'Home Improvement & Tools');
insert into listing_types values (3752, 'Industrial & Scientific');
insert into listing_types values (3753, 'Jewelry & Watches');
insert into listing_types values (3754, 'Kitchen');
insert into listing_types values (3755, 'Memorabilia & Collectibles');
insert into listing_types values (3758, 'Musical Instruments');
insert into listing_types values (3759, 'Office Products');
insert into listing_types values (3760, 'Pet Supplies');
insert into listing_types values (3761, 'Pottery & Glass');
insert into listing_types values (3762, 'Real Estate');
insert into listing_types values (3763, 'Software');
insert into listing_types values (3764, 'Sporting Goods');
insert into listing_types values (3765, 'Tickets');
insert into listing_types values (3766, 'Toys, Games, & Hobbies');
insert into listing_types values (3767, 'Unclassified - Everything Else');
insert into listing_types values (3768, 'Video Games');


/* Define the media types table.  Each media type also infers a listing type. */

create table media_types (
	id		serial,
	display_order	int not null,
	name		varchar(20) not null,
	listing_type	int not null,

primary key(id)
);
comment on table media_types is 'Store the different types of media.  Each media type also infers a listing type.';

/* Listing type: 3757, Music */
insert into media_types values (DEFAULT, 1, 'LP', 3757);
insert into media_types values (DEFAULT, 2, 'LP:10''', 3757);
insert into media_types values (DEFAULT, 3, '7''', 3757);
insert into media_types values (DEFAULT, 4, '12''', 3757);
insert into media_types values (DEFAULT, 5, 'Single:12''', 3757);
insert into media_types values (DEFAULT, 6, 'EP:12''', 3757);
insert into media_types values (DEFAULT, 7, '45', 3757);
insert into media_types values (DEFAULT, 8, '45:EP', 3757);
insert into media_types values (DEFAULT, 9, '45:10''', 3757);
insert into media_types values (DEFAULT, 10, '45:12''', 3757);
insert into media_types values (DEFAULT, 11, '45:PicSleeve', 3757);
insert into media_types values (DEFAULT, 12, '78', 3757);
insert into media_types values (DEFAULT, 13, 'CD', 3757);
insert into media_types values (DEFAULT, 14, 'CD:SINGLE', 3757);
insert into media_types values (DEFAULT, 15, 'CD:EP', 3757);
insert into media_types values (DEFAULT, 16, 'CD:Mini', 3757);
insert into media_types values (DEFAULT, 17, 'CD:Enhanced', 3757);
insert into media_types values (DEFAULT, 18, 'MiniDisc', 3757);
insert into media_types values (DEFAULT, 19, 'SACD', 3757);
insert into media_types values (DEFAULT, 20, 'DVD:AUDIO', 3757);
insert into media_types values (DEFAULT, 21, 'CASSETTE', 3757);
insert into media_types values (DEFAULT, 22, 'DAT', 3757);
insert into media_types values (DEFAULT, 23, 'REEL-TO-REEL', 3757);
insert into media_types values (DEFAULT, 24, '8-TRACK', 3757);
insert into media_types values (DEFAULT, 25, 'CDROM', 3757);

/* Listing type 3737, Books, Magazines, & Comics */
insert into media_types values (DEFAULT, 26, 'HARDBACK', 3737);
insert into media_types values (DEFAULT, 27, 'PAPERBACK', 3737);
insert into media_types values (DEFAULT, 28, 'MAGAZINE', 3737);
insert into media_types values (DEFAULT, 29, 'COMIC', 3737);
insert into media_types values (DEFAULT, 30, 'BOOKLET', 3737);
insert into media_types values (DEFAULT, 31, 'SHEET MUSIC', 3737);

/* Listing type 3756, Movies & Videos */
insert into media_types values (DEFAULT, 32, 'DVD', 3756);
insert into media_types values (DEFAULT, 33, 'BLURAY', 3756);
insert into media_types values (DEFAULT, 34, 'HDDVD', 3756);
insert into media_types values (DEFAULT, 35, 'VHS NTSC', 3756);
insert into media_types values (DEFAULT, 36, 'VHS PAL', 3756);
insert into media_types values (DEFAULT, 37, 'SVHS', 3756);
insert into media_types values (DEFAULT, 38, 'BETA', 3756);
insert into media_types values (DEFAULT, 39, 'VIDEOCD', 3756);
insert into media_types values (DEFAULT, 40, 'LASERDISC', 3756);
insert into media_types values (DEFAULT, 41, 'VIDEODISC', 3756);
insert into media_types values (DEFAULT, 42, '8MM PROJECTOR', 3756);
insert into media_types values (DEFAULT, 43, 'SUPER8', 3756);
insert into media_types values (DEFAULT, 44, '16MM', 3756);
insert into media_types values (DEFAULT, 45, '35MM', 3756);


/* Define the conditions we use to grade media. */

create table conditions (
	id		serial,
	display_order	int not null,
	brief		varchar(6) not null,
	name		varchar(20) not null,
	description	varchar(1000),

primary key(id)
);
comment on table conditions is 'Store the list of grades for our media.';

insert into conditions values (DEFAULT, 1, 'SS', 'Still Sealed',
	'Never opened. Flawless, with no damage whatsoever.');

insert into conditions values (DEFAULT, 2, 'M', 'Mint',
	'Has been opened, but is still flawless with no damage whatsoever.  Vinyl & CD: No visible marking / scuffing / scratches & plays perfectly.');

insert into conditions values (DEFAULT, 3, 'EX', 'Excellent',
	'Vinyl: May have scuff marks and signs of some wear but will still play almost perfectly throughout, with only "barely detectable" crackles or pops. A slight noise at the begining is allowable, but the remainder must be nearly flawless. Definitely no scratches or gouges that a touch with a dry finger can feel.  Cover: May only have the slightest signs of normal wear.');

insert into conditions values (DEFAULT, 4, 'VG', 'Very Good',
	'The majority of saleable albums fall under this grade.  CD: Visible scratches but plays perfectly all the way through.  Vinyl: May crackle, pop or make other annoying noises, but only occasionally,never continuously, and not more loudly than the music being listened to Cover: Normal used cover wear such as ring wear and split seams. If there is abnormal damage such as tears or markings, but the seller still feels that it qualifies as a "VG", the damage must be described in comments attached to the item.');

insert into conditions values (DEFAULT, 5, 'G', 'Good',
	'"Good" actually means "trashed" in collector circles!  CD: one or more tracks skip.  Vinyl: May have continuous low level crackles, pops, etc... but not so loud as to make the music completely unlistenable or unenjoyable to the casual listener. Might also have "nasty little scratch" causing popping on one or two more songs, with the rest of record playing fine.  Cover: More than normal wear and tear.');

insert into conditions values (DEFAULT, 6, 'F', 'Fair',
	'i.e. Vinyl: Only one side playable');

insert into conditions values (DEFAULT, 7, 'P', 'Poor',
	'i.e. Only one or two songs on the whole album are playable.');

insert into conditions values (DEFAULT, 8, 'U', 'Unknown',
        'This item has not been examined so the condition is not known.');

/* Define a list of categories to be used for listings. */

create table categories (
	id		serial,
	name		varchar(15),

primary key(id)
);
comment on table categories is 'Define the list of categories to be used for listings.';

insert into categories values (DEFAULT, 'Classical');

/* Define the list of artists. */

create table artists (
	id		serial,
	name		varchar(80) not null,

primary key(id)
);
comment on table artists is 'Defines the list of known artists.';

insert into artists values (DEFAULT, 'Unspecified');

/* Define the big catalog table.  One entry per piece of media! */
create table catalog (
	id		serial,
	title		varchar(80) not null,
	artist		int not null,
	media_type	int not null,
	cover_condition int not null,
	media_condition int not null,
	price		money not null, /* USD */
	category	int not null,
	description	varchar(16000) not null, /* GEMM limit */
	label		int not null,
	release_number	varchar(10),
	release_year	int,
        release_month   int,
        release_day     int,
	release_country	varchar(10),
	mono_stereo	int not null,
	nrecinset	int not null, /* Number of records in set */
	onhand		int not null,
	primary_picture	int,
	physical_location varchar(35),

primary key(id)
);
comment on table catalog is 'The catalog table has one record for each piece of media, and defines the meaningful details of that media.``';

create table catalog_pictures (
    catalog_id          int not null,
    picture_id          int not null,
    number              int,

primary key(catalog_id, picture_id)
);
comment on table catalog_pictures is 'The catalog_pictures table maps extra pictures to catalog entries.';

/* Users */
create table users (
	id		serial,
	username	varchar(80) not null unique,
	password	varchar(80) not null,
	email		varchar(80) not null,
	first_name	varchar(40) not null,
	last_name	varchar(40) not null,
	active		int not null default 0,

primary key(id)
);
comment on table users is 'User list.';

insert into users values (2, 'tester', 'testing', 'tester@example.com',
	'Test', 'User', 1);

/* Roles */
create table roles (
	id		serial,
	role		varchar(40),

primary key(id)
);
comment on table roles is 'User roles.';

insert into roles values(1, 'Administrator');
insert into roles values(2, 'Editor');

create table user_role (
	user_id integer not null,
	role_id integer not null,
primary key(user_id, role_id)
);
comment on table user_role is 'Map users to roles.';

insert into user_role values (1, 1);
insert into user_role values (1, 2);

/* Create a table in your database for sessions */
create table  sessions (
	id           CHAR(72) PRIMARY KEY,
	session_data TEXT,
	expires      INTEGER
);
comment on table sessions is 'Storage for session data.';

/* Add foreign keys! */
alter table media_types add foreign key ("listing_type")
	references listing_types ("id");

alter table catalog add foreign key ("artist")
	references artists ("id");

alter table catalog add foreign key ("media_type")
	references media_types ("id");

alter table catalog add foreign key ("cover_condition")
	references conditions ("id");

alter table catalog add foreign key ("media_condition")
	references conditions ("id");

alter table catalog add foreign key ("category")
	references categories ("id");

alter table catalog add foreign key ("label")
	references labels ("id");

alter table catalog add foreign key ("mono_stereo")
	references mono_stereo_types ("id");

alter table catalog add foreign key ("primary_picture")
	references pictures ("id");

alter table catalog_pictures add foreign key ("picture_id")
        references pictures ("id");

alter table catalog_pictures add foreign key ("catalog_id")
        references catalog ("id");

alter table user_role add foreign key ("user_id")
	references users ("id");

alter table user_role add foreign key ("role_id")
	references roles ("id");
