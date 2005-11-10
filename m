From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: git and cogito update, gitweb problem
Date: Thu, 10 Nov 2005 13:02:01 +0100
Message-ID: <20051110120201.GE22064@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
X-From: git-owner@vger.kernel.org Thu Nov 10 13:04:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaB9s-0005cY-0E
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 13:04:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVKJMD5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 07:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVKJMD4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 07:03:56 -0500
Received: from [217.14.64.54] ([217.14.64.54]:20384 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750797AbVKJMD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 07:03:56 -0500
Received: (qmail 25295 invoked by uid 1000); 10 Nov 2005 12:02:01 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11481>


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again!

I just wanted to present you an automatic git and cogito updating script,
but I've still the problem with '+' in filenames in gitweb [0].
If somebody tells me what would be the finest / best way to fix that
in gitweb (i am not that perl guru) I'll fix it myself.

So currently I copied the script temporarily to [1].

I use it to install the latest git and cogito automatically.

Please comment / critize.

Nico


[0]: http://linux.schottelius.org/cgi-bin/gitweb.cgi?p=3DcLinux/dev-scripts=
=2Egit;a=3Dblob;h=3D86f24af137034bb44bc3ce866cd6b20d8ea5ff94;hb=3Da1ad5cd34=
497c0cd870c138039eda15dd6fea02f;f=3Dupdate-git+cogito.sh
[1]: http://creme.schottelius.org/~nico/temp/update-git+cogito.sh

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ3M2uLOTBMvCUbrlAQJO2w//UzI8TeqLJ8dOjv8QNM4UwBdoiKK4fKwz
exRtFvJN+qV12ReXoQHbWKXIBZbSLxk1h8U9L+1f4DetaU74LaaJ9Z26+rmgL0ud
ugGqUcHTgwN3MRdm6WvK/MyMtXNx/GJqUUqfWwUrV0eeMg/Is4h+AlFz8uvighxu
Jm4onLFDnw/euVQZBdVBYk4aIJkLtyyv5o8NOKBMUHI1Hj5kpFEuhiwR1KmANMci
lnvlQ0jFyIdtvG7RKkf1b/3MxwCxXDegSEKn9QHoiEAgk6MjeJqcU+ySA16lr5qA
h1DZEbamQb5QWixWCX6aBBoLWICebzaagx1rh6OZiuTNA5IxrEUifekLo8cshlEa
T61JKV79phVxysXp9ZYdrpLerkT+21Zhtt9EwqZsesmRdZslgbuysMMr0kMcc7o5
c1A3QmE608aAls++2n7dtgmWB1el3qu1TML+WItZvu4VxvzfQMnwvANNb6RM/Dm/
TsxPAsGPta8oxf9wCMNpjSi1XeSyc/EZn5tSKJ+M2DmrbxTs9JPYYMCp4qGR5nhD
qoOBpHXmfbcUFBEyhmmHRWTeDJnOsOrZIluAYuLS0p7q6a3LdGUY7PFFa1q7XWR+
T8lkBJ19RTDXVZrIS6F+6rtJFXAE6eJeD16isoRDC6w6fEufRk632llfx90gfQV4
U0fMboW26Ro=
=xl5a
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
