From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: Gitweb feature requests, Bug?
Date: Wed, 19 Oct 2005 10:12:14 +0200
Message-ID: <20051019081214.GJ22986@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQAwcd5tHl0Qlnzi"
X-From: git-owner@vger.kernel.org Wed Oct 19 10:14:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES93v-0002z5-8p
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVJSIMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbVJSIMg
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:12:36 -0400
Received: from wg.technophil.ch ([213.189.149.230]:44193 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932403AbVJSIMf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:12:35 -0400
Received: (qmail 23800 invoked by uid 1000); 19 Oct 2005 08:12:14 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10271>


--LQAwcd5tHl0Qlnzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

There are some things we see here, which are problematic:

- Clicking on history for a file does not return the last commit, but every
  commit _before_ the last commit. Is this wanted? We were searching for th=
at
  specific commit and wondered why it is not in the history
- when selecting the blob of a file, we miss
   o the sha1sum=20
   o a link to the history
- Still there's the probelm having a '+' in the filename

Could you change gitweb so it does those things or if you've no time would =
you accept
a patch for it that does that?

Greetings,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--LQAwcd5tHl0Qlnzi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1X/3rOTBMvCUbrlAQKMGRAAnJjSsS1XesaA0dDe1mvW169LlpH2ziJf
zbgwX5OkZaPHU0TfV/rO7x17QfSboUKn6Q4O2GBuzjBrRRRPvn9jqepYFdwslOQ8
WS1Lqw73NXIJNmh9yD2oWHf1B/UnLDd+6esE7MYr3B8/SwbJ6xoq1tG+ry2mcF8Y
8fJw48yyG8ZJZ1tYcCFnM7mR2p9xiYhQ4DE3VAyzZP5/uEcDw/fjjydfJu3pSlOR
DJ1eALrmbV5FeTiXDp6Al23XJBMT3ZK79IlYV4r8jyhqRO0Vye4fzqlP3baUGG9h
TWQIyiN9ImuaPJKw+xjOQm3vJuTpRFl8vzlY/HqQzwRHZkVXnofSyO7yEvxnDvrl
DqD6r7IRWhWsSE9+jyR9xjFGwB7ioryOYmblRLMrCsY20JC/Cvs5qNMLQ+JAphi9
XiV3KpfXHy+KOmNfFe9K4zTShrgQiXmcdxta5DhVRZ2kypwcqfGeEysoAdzNVpzM
D8BS2aQDjh7mcjYXo1pO98YCERxIowz1OH0TnJl5JJPRZ+kcmMudUR04O1ZzizfV
De15fOeJFel3xYmaBOrOzjZxapEef6QBRw+GadpnLNC7j8dRZKiIIopKlpOJtufq
ZiL2K1tl2mcJ3Tw5BLLpXm6UI/5TlEemUMi5DPdjBeJBwPxyfuCHVSU4cufm/+9P
faozWE+/HI4=
=FbTq
-----END PGP SIGNATURE-----

--LQAwcd5tHl0Qlnzi--
