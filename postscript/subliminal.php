#!/usr/bin/env php
<?php
// Do some echoing, why? why not..
echo "Starting the Sonarr.php postprocessing script\n";
// for some reason, environment variables from the cli is hiding in $_SERVER, don't ask me, php is silly sometimes
$envVars = $_SERVER;
// All the env variables attached to variables
$title = isset($envVars["sonarr_series_title"]) ? $envVars["sonarr_series_title"] : null; // Not Safe for Work (2015)
$filePath = isset($envVars["sonarr_episodefile_path"]) ? $envVars["sonarr_episodefile_path"] : null; // /storage/TV Shows/Not Safe for Work (2015)/Season 1/Not Safe for Work (2015) - S01E01 - Episode 1.mkv
$sceneName = isset($envVars["sonarr_episodefile_scenename"]) ? $envVars["sonarr_episodefile_scenename"] : null; // "Not.Safe.For.Work.UK.S01E01.720p.HDTV.x264-TLA
$airDate = isset($envVars["sonarr_episodefile_episodeairdatesutc"]) ? $envVars["sonarr_episodefile_episodeairdatesutc"] : null; // 6/30/2015 8:00:00 PM
$seasonNumber = isset($envVars["sonarr_episodefile_seasonnumber"]) ? $envVars["sonarr_episodefile_seasonnumber"] : null; // 1
$relativePath = isset($envVars["sonarr_episodefile_relativepath"]) ? $envVars["sonarr_episodefile_relativepath"] : null; // Season 1/Not Safe for Work (2015) - S01E01 - Episode 1.mkv
$eventType = isset($envVars["sonarr_eventtype"]) ? $envVars["sonarr_eventtype"] : null; // Download
$episodeAirDates = isset($envVars["sonarr_episodefile_episodeairdates"]) ? $envVars["sonarr_episodefile_episodeairdates"] : null; // 2015-06-30
$seriesID = isset($envVars["sonarr_series_id"]) ? $envVars["sonarr_series_id"] : null; // 339
$seriesPath = isset($envVars["sonarr_series_path"]) ? $envVars["sonarr_series_path"] : null; // /storage/TV Shows/Not Safe for Work (2015)
$tvdbID = isset($envVars["sonarr_series_tvdbid"]) ? $envVars["sonarr_series_tvdbid"] : null; // 297084
$episodeNumbers = isset($envVars["sonarr_episodefile_episodenumbers"]) ? $envVars["sonarr_episodefile_episodenumbers"] : null; // 1
$fileID = isset($envVars["sonarr_episodefile_id"]) ? $envVars["sonarr_episodefile_id"] : null; // 27224
$releaseGroup = isset($envVars["sonarr_episodefile_releasegroup"]) ? $envVars["sonarr_episodefile_releasegroup"] : null; // tla
$quality = isset($envVars["sonarr_episodefile_quality"]) ? $envVars["sonarr_episodefile_quality"] : null; // HDTV-720p
$qualityVersion = isset($envVars["sonarr_episodefile_qualityversion"]) ? $envVars["sonarr_episodefile_qualityversion"] : null; // 1
// If the event isn't download, just die here
if($eventType != "Download")
    die();
// Make sure the filepath is set
if($filePath != null)
{
    // make sure the file path is actually real
    if(file_exists($filePath))
    {
        // Dump some stuff into the log
        file_put_contents("/config/subliminal_post_script.log", "Converting {$filePath}", FILE_APPEND);
        // Now execute the sickbeard mp4 converter so we can convert the file to an mp4 with the settings we've set
        exec('/usr/local/bin/subliminal -l en -p opensubtitles -p addic7ed -p subscenter -m 70 "$filePath"');
    }
}
