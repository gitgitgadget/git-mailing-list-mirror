From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: git for pushing local subdir to website
Date: Mon, 3 Aug 2009 12:01:36 -0600
Organization: icecavern.net
Message-ID: <200908031201.41039.wjl@icecavern.net>
References: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2760022.ACtMCTFfal";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt Di Pasquale <pasquale@fas.harvard.edu>
X-From: git-owner@vger.kernel.org Mon Aug 03 20:02:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY1rX-0006Cy-Hy
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 20:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbZHCSBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbZHCSBv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 14:01:51 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:44547 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753067AbZHCSBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 14:01:50 -0400
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 943AE35A3B;
	Mon,  3 Aug 2009 20:01:48 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.29-2-amd64; KDE/4.2.2; x86_64; ; )
In-Reply-To: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com>
X-Face: #;qMWg=Msk*d]z]X1P2-t9]~6+RoGF$nJo89f%|Y`^whfl3Wj$X2Q_1u)ZAW@Hx|g)J]!)
 =?utf-8?q?=0A=09Br0=3FK3Imj?=)np=]r*QN,Q8].V99^Og'xl-d9FM~$yaSGB"mfXb>x[QNi[()
 =?utf-8?q?oob=60/4M42=26We=0A=09cC1jq=3DQ=5CS?=@ck\>H@
 =?utf-8?q?t=26Y7Y=3Apub=3DHOWqY=7D-d=5CwrCxvsTo7k1Ek=7DqQO=5D5=7EngK=5E=25?=
 =?utf-8?q?cT5IzmmG=5BQ=0A=09Nha=7D=5DAmI=60R-6m84VcWT4=236c?=)1`>t{$~l6:gZMtv18ge'!d[Yk-/?T3>C5O-|6On4(
 =?utf-8?q?N=7BAV=23=0A=094Eyw52=5B=3A=25Z?=>#"c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124710>

--nextPart2760022.ACtMCTFfal
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 August 2009 11:11:13 Matt Di Pasquale wrote:
> now... how do i just push example.com and not extra and example.com?
[...]
> that doesn't really make sense conceptually because example is one big
> project. extra is like extra files and example.com is like what i
> really want to go on web server...

There are several ways to do this with git, but since you are not going to=
=20
make commits on the server itself, have you considered simply pushing the=20
production files you want with e.g. rsync?

--nextPart2760022.ACtMCTFfal
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkp3JgEACgkQ8KmKTEzW49KTwwCdGSZ2Z+7tneJyryKjBTU4l6Mx
qj0AoJSocln6qEukvrItHHgdS4+96cmK
=4kNV
-----END PGP SIGNATURE-----

--nextPart2760022.ACtMCTFfal--
