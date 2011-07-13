From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: Re: Integrating GIT with Project Management Systems
Date: Tue, 12 Jul 2011 19:23:59 -0600
Organization: icecavern.net
Message-ID: <201107121923.59542.wjl@icecavern.net>
References: <1310517600171-6577341.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2946169.Zt2haXA0qs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thaddeus <t-tcambron@trxtraining.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 03:29:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgoGZ-0005do-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 03:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab1GMB30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 21:29:26 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:55542 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756082Ab1GMB30 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 21:29:26 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jul 2011 21:29:25 EDT
Received: from tonberry.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id 3087E35B28;
	Tue, 12 Jul 2011 19:24:06 -0600 (MDT)
User-Agent: KMail/1.13.7 (Linux/2.6.32-5-amd64; KDE/4.6.4; x86_64; ; )
In-Reply-To: <1310517600171-6577341.post@n2.nabble.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176990>

--nextPart2946169.Zt2haXA0qs
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 12, 2011 18:40:00 thaddeus wrote:
> How important is it to have your repository integrated with your project
> management system. What if integration is not possible as with Clarizen.
> Anyone have any idea for a work around or implementing through an API?

Having used several VCS with and without integration into a project=20
management system on many different projects, my personal experience is tha=
t=20
this type of integration usually is more trouble than it's worth.

It's especially annoying with distributed version control systems, because=
=20
it promotes an everybody-push-into-the-same-repository type workflow which=
=20
causes more problems than any project management system integration could=20
ever solve.

Just my 2 cents.

--nextPart2946169.Zt2haXA0qs
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4c868ACgkQ8KmKTEzW49LBEACfdW3KZf9li6cviB1mrLnEMBnd
KAYAn2tyvCPhw++LOIOINgFCe5jMuKH+
=3bTo
-----END PGP SIGNATURE-----

--nextPart2946169.Zt2haXA0qs--
