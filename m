From: Velemoochi <momochi2015@gmail.com>
Subject: Convert MKV with DTS to AC3 to Chromecast for playback
Date: Tue, 10 Mar 2015 21:10:46 -0700 (MST)
Message-ID: <1426047046245-7626880.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 05:10:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVXyt-0005Kt-So
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 05:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbbCKEKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2015 00:10:47 -0400
Received: from mwork.nabble.com ([162.253.133.43]:50328 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbbCKEKq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 00:10:46 -0400
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id C826C16DF5E2
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 21:10:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265296>

Convert MKV with DTS to AC3 to Chromecast for playback

Here is a step by step guide to convert MKV with DTS-HD Master Audio to=
 AC3
5.1 for playing on Google Chromecast on Windows and Mac.

Question:=20

/I am trying to play an MKV file which is encoded with DTS on ChromeCas=
t via
DSVideo. DS Video informs me that it cannot manage DTS, and ChromeCast =
also
does not support DTS. I own a ds214play. What I want to do is transcode=
 DTS
-> Dolby Digital AC3. I have installed a package I found on the Synolog=
y
forums to enable DS Video to  decode DTS
<http://forum.synology.com/enu/viewtopic.php?f=3D222&t=3D81266&start=3D=
60#p336806>=20
=2E This works fine, however when I cast from DS Video to CC now, it sh=
ows a
grey box with an exclamation mark. Any solutions?/

In mention of DTS audio, we often refer to DTS Digital Surround, DTS-HD
Master Audio, DTS Neural Surround, DTS Neo: X. All of the them are famo=
us
for high definition audio quality and widely used for in-movie sound on
film, DVD, CD, HD DVD and Blu-ray Disc. However, DTS encoded audio or v=
ideo
files are incompatible with your Chromecast as above.

* Read  Chromecast Column
<http://onebestsoft.com/hot-topics/storage/chromecast/> =20

In order to successfully play MKV with DTS audio on chromecast anywhere=
, a
recommended solution is to convert DTS to  supported format by Chromeca=
st
<http://www.video-pedia.com/2015/02/03/stream-video-formats-to-google-c=
hromecast/> =20
and more popular audio format like AC3. The following will introduce a
powerful DTS Converter as well as a step by step guide on how to conver=
t MKV
with DTS to AC3 to play on CC.

Preparation:

To perform DTS to AC3 conversion in simple steps while still keeping th=
e
original quality,  Pavtube Video Converter Ultimate
<http://www.multipelife.com/video-converter-ultimate>   (Read  Review
<http://best-tablet-converter.com/2014/08/03/top-5-best-video-converter=
-ultimate-programs-reviewed/>=20
) is what you need. It is simple to use and features fast conversion sp=
eed.
With this excellent DTS to AC3 audio converter, you can convert movies,=
 TV
shows, and music video with unsupported formats to chromecast with the =
audio
format you need, like 5.1 channels, stereo or mono depending your sourc=
e
audio.

Here is how to convert DTS to AC3 audio format for Chromecast

1. Import source media files=20

Download
<http://www.multipelife.com/download/video-converter-ultimate/video_con=
verter_ultimate_setup.exe>=20
, install and run Pavtube Video Converter Ultimate. Click "Add video" b=
utton
to load your source MKV with DTS files into the program. The DTS to AC3
Converter is multi-task based and supports batch conversion, this means=
 you
can load in multiple video files to convert at one time.
 =20
<http://open-mobile-share.com/wp-content/uploads/2014/05/video-converte=
r-ultimate.png>=20

2. Select output format=20

The default Chromecast video formats are MP4 and WebM. It also supports
MPEG-DASH, Smooth Streaming, and HTTP Live Streaming (HLS) video files.

=46rom the Format bar, navigate to "Common Video" catalogue, here both =
MP4 and
MKV are suitable for your Chromecast. =20

<http://open-mobile-share.com/wp-content/uploads/2014/05/h.264-mp4-form=
at.png> =20

3. Set AC3 audio

Click "Settings" button, the "Profile Settings" windows pops up, on whi=
ch
you can set the Audio Codec to AC3 and Channels to 5.1 Channels. This
ensures your output audios to be encoded with ac3 5.1. Otherwise, you c=
an
keep your channels as Stereo.

Apart from that, you are also allowed to reset audio bit rate and sampl=
e
rate on this window.

4. Start conversion

Click "Convert" button to start converting MKV DTS to Chromecast suppor=
ted
format with 5.1/Stereo Channels. As soon as the conversion finished, yo=
u can
click "Open" button to get the generated files with ease.=20

Another good thing about Pavtube Video Converter Ultimate is, it offers=
 a
"Shut down computer after conversion" option, so if you don=E2=80=99t w=
ant to wait
around in front of your computer for the entire conversion process, you=
 can
tick off it and go away to do other things.=20

If you are mac users, turn to  iMedia Converter for Mac
<http://www.multipelife.com/imedia-converter-mac>  .=20

Now start  streaming
<http://onebestsoft.com/stream-video-from-devices-to-chromecast/> =20
converted files using your Chromecast media player

1.Connect with your Mobile device

Download and open the Chromecast app on your Android or iOS smartphone =
or
tablet using Google Play or the App store.

Note: You should ensure that your mobile device is connected to your Wi=
-Fi
and not mobile network. Also, you must have the latest app installed an=
d be
on the same network as your Chromecast digital media player.

2. Connect with your Computer

* Open the Chrome browser and the setup Chromecast.
* Download the Chromecast app to your computer.

3. Connect with YouTube

* Connect your Chromecast device to an available HDMI slot on your HDTV=
=2E=20
* When your Chromecast digital media player is securely connected to yo=
ur TV
you will see the Chromecast * Home screen with your Wi-Fi name at the b=
ottom
of the screen.=20
* Now, download the YouTube app on your Android or Apple tablet or
smartphone.=20
* Connect your Android or Apple device to the same Wi-Fi network as you=
r
Chromecast device.
* Open the YouTube app on your Android or Apple device and click the Ca=
st
button  to start streaming videos. =20

Related tips:=20

Can't Play MKV, AVI, MP4, FLV, WMV, MPG, MOV by Chromecast-Troubleshoot
<http://video-tips.jimdo.com/2015/02/10/convert-video-to-chromecast/> =20
Cast iTunes Movies TV Shows to Chromecast for enjoying on TV
<http://multimediatips.jimdo.com/2015/02/14/stream-itunes-movies-to-chr=
omecast/> =20
How to Cast unsupported MKV video Files through a Chromecast
<http://onebestsoft.com/stream-mkv-to-chromecast/> =20
Stream/Transfer ISO files to Chromecast within 3 clicks
<http://open-mobile-share.com/copy-blu-ray-dvd-iso-to-chromecast/> =20
Simple way to stream DVD to play on TV via Chromecast
<http://media-playback.jimdo.com/2014/12/19/rip-dvd-to-chromecast/> =20
Keep DTS-HD MA when converting Blu-ray for Chromecast via Plex
<http://www.multipelife.com/rip-blu-ray-with-dts-hd-ma-audio.html> =20
=20
Souce:=20
http://bestvideosolution.blogspot.com/2014/12/convert-dts-to-ac3-for-ch=
romecast.html
<http://bestvideosolution.blogspot.com/2014/12/convert-dts-to-ac3-for-c=
hromecast.html> =20



--
View this message in context: http://git.661346.n2.nabble.com/Convert-M=
KV-with-DTS-to-AC3-to-Chromecast-for-playback-tp7626880.html
Sent from the git mailing list archive at Nabble.com.
