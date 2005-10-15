From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Re: gitweb
Date: Sat, 15 Oct 2005 21:37:01 +0200
Message-ID: <20051015193701.GL12774@schottelius.org>
References: <20051015193146.GK12774@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CqfQkoYPE/jGoa5Q"
X-From: git-owner@vger.kernel.org Sat Oct 15 21:38:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQrqJ-00047k-SU
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 21:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJOThQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 15:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVJOThQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 15:37:16 -0400
Received: from wg.technophil.ch ([213.189.149.230]:28645 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751211AbVJOThO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 15:37:14 -0400
Received: (qmail 16222 invoked by uid 1000); 15 Oct 2005 19:37:01 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051015193146.GK12774@schottelius.org>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10142>


--CqfQkoYPE/jGoa5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nico -telmich- Schottelius [Sat, Oct 15, 2005 at 09:31:46PM +0200]:
> 1. problems getting gitweb
>=20
> [21:26] creme:build% cg-clone http://www.kernel.org/pub/scm/git/gitweb.cgi

oops, my fault: s/cgi/git/

3. Problem with "+" in filenames still exists:

http://linux.schottelius.org/cgi-bin/gitweb.cgi?p=3DcLinux/cinit.git;a=3Dtr=
ee;h=3D45484bc0aa87c816bfe18e5eea3cddba1bddf966;hb=3D2c2ae29df1471b6542476f=
b720da5b55dc149718;f=3Dcontrib+tools

4. another error happens:

----------------------------------------------------------------------
[...]
walk d8d17b5debd37a3f0e42eba2d69d375b74f20fe9
progress: 55 objects, 248306 bytes
walk f7ab660c15b5e3cb7fee035191e0cd5160bf8299
progress: 58 objects, 262710 bytes
walk e4669df9a6f638299ebab57cc87318a2a9e24b0c
progress: 61 objects, 276940 bytes
walk f5dfb3f6a6655d4d60fdd0aaeef7b5b14226147f
progress: 63 objects, 290809 bytes
error: The requested URL returned error: 404
Getting pack list
error: The requested URL returned error: 404
Getting alternates list
error: Unable to find d263a6bd453df849c9f9211f1966c830c3cf913a under http:/=
/www.kernel.org/pub/scm/git/gitweb.git/

Cannot obtain needed commit d263a6bd453df849c9f9211f1966c830c3cf913a
while processing commit f5dfb3f6a6655d4d60fdd0aaeef7b5b14226147f.
cg-fetch: objects fetch failed
cg-clone: fetch failed
----------------------------------------------------------------------

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--CqfQkoYPE/jGoa5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1FaXLOTBMvCUbrlAQK4HQ/9FFDrfwGABd/EWvugSGQQHHI3qzbEYH3+
/6tpBT7T5Hv7R7ZHkzs8ngXDIHoqihxJEAu5cGAwUWcu9Jva6LTud4NkGGefHAkw
sbrGIPXCxjZsp2Z0dOG4zhMQ4Ewrjo4UjIIRTGFsjsNTkpaXmq8wAFYGcGwpv6zI
pSF3TRV2/grkVayRuc5CnO2WukE1bo2NLtBY7W/tNdxzEW1pOi0T4c7iCj/bgoRe
GTUF8AP0GS1DrAlTKf+f130Tb+hQfSRLb3FkbxvlcfKpUvd0JWFbgcmhqtE2Q3nB
0WKQB1T2u7SQ6VsbGrf9YhquMFs0VDSKPK0spjfUrQLQ4AU8Ur99hiU9geXljuYk
ophMJakv/8vMpOe3qjvs4AmXBbW/xVANYdHcC6ccszTQfp2p+myOPwOIuR7stCDL
m1QNCeJ3UU4l5dH2uh+22XeHyeg0wpeVNokNFl5GSVY55MmoVq6Z2eqcYr944+ZI
udkj0Q47G1A4MvYo6JSkqc1h+aLxt38Te5OnPKOvu30BgY+s+c4nvbPd9yXvU2X9
ps9a19ZUVjhYP5U1w3hfM2vWpzZ6WXxL5ye2aefxy73OeC+xVgV3qXkIsXyWxUwG
zMf7PBSlqO7IlrtgBt/sQ0A95095L+EydWEb4UqC0pB2bldCeRAnE1afqxzyMHVv
nbPE2uqmCho=
=i6Zz
-----END PGP SIGNATURE-----

--CqfQkoYPE/jGoa5Q--
