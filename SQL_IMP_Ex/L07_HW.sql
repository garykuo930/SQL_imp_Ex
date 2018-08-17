------------------------------------------------------------------------------------------------------------
--串聯所有資料表做查詢
------------------------------------------------------------------------------------------------------------
use CGSS

select Idol_Name,
Type_Name,
Ability_Name,
Song_Name as 'Solo Song',
Composer_Name
from Idols
join Types
on Idols.Type_ID = Types.Type_ID
join Idol_Abilities
on Idols.idol_id = Idol_Abilities.Idol_ID
join Abilities
on Idol_Abilities.Ability_ID = Abilities.Ability_ID
join Songs
on Solo_Song_ID = Song_ID
join Composer
on Songs.Composer_ID = Composer.Composer_ID
join Ability_Required
on Songs.Song_ID = Ability_Required.Song_ID
order by Idol_Name
------------------------------------------------------------------------------------------------------------
--查詢不是角色曲的歌曲
------------------------------------------------------------------------------------------------------------
use CGSS

select Song_ID,Song_Name,Type_Name,Type_Color,Composer_Name
from Songs
join Composer
on Songs.Composer_ID = Composer.Composer_ID
join Types
on Songs.Type_ID = Types.Type_ID
where Song_ID not in(
	select Solo_Song_ID from Idols
	where Solo_Song_ID is not null)
------------------------------------------------------------------------------------------------------------
select Song_Name,Ability_Name
from [dbo].[Ability_Required]
join Songs
on Songs.Song_ID = Ability_Required.Song_ID
join Abilities
on Abilities.Ability_ID = Ability_Required.Ability_ID
------------------------------------------------------------------------------------------------------------