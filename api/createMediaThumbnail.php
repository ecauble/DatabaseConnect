<?php
$frame = 10;
$movie = '../media/thrive1.mp4';
$thumbnail = 'thumbnail.png';

$mov = new ffmpeg_movie($movie);
$frame = $mov->getFrame($frame);
if ($frame) {
    $gd_image = $frame->toGDImage();
    if ($gd_image) {
        imagepng($gd_image, $thumbnail);
        imagedestroy($gd_image);
        echo '<img src="'.$thumbnail.'">';
    }
}
?>