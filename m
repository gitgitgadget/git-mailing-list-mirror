From: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: New script: build-git
Date: Sun, 27 Sep 2009 15:33:34 +0200
Message-ID: <20090927133334.GA6915@triton>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 27 15:42:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrtzi-0007hi-1U
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 15:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbZI0NkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 09:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbZI0NkR
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 09:40:17 -0400
Received: from smtp.domeneshop.no ([194.63.248.54]:44936 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752158AbZI0NkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 09:40:16 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2009 09:40:16 EDT
Received: from sfn-inkubator-70-248.hib.no ([158.37.70.248] helo=triton)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <sunny@sunbase.org>)
	id 1Mrtse-0005aQ-7R
	for git@vger.kernel.org; Sun, 27 Sep 2009 15:33:36 +0200
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129208>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It=E2=80=99s important to have the bleeding-edge Git installed on all compu=
ters=20
I use, so I created a bash script to automatically download, install and=20
test new versions from the master branch. It=E2=80=99s been maturing now fo=
r=20
some weeks, and works fine on all computers I use, which is Ubuntu and=20
Debian based. It=E2=80=99s built with paranoia in mind to avoid accidents, =
and=20
places each version under its separate directory structure under=20
/usr/local by default, but that=E2=80=99s easily configurable.

In case someone else has use for such a script, it=E2=80=99s available from

  git://github.com/sunny256/build-git.git
  http://github.com/sunny256/build-git.git

or

  git://gitorious.org/build-git/build-git.git
  http://git.gitorious.org/build-git/build-git.git

Comments and patches/enhancements welcome.

Regards,
=C3=98yvind

+-| =C3=98yvind A. Holm <sunny@sunbase.org> - N 60.39548=C2=B0 E 5.31735=C2=
=B0 |-+
| OpenPGP: 0xFB0CBEE894A506E5 - http://www.sunbase.org/pubkey.asc |
| Fingerprint: A006 05D6 E676 B319 55E2  E77E FB0C BEE8 94A5 06E5 |
+------------| 47ab564a-ab68-11de-8e10-00248cd5cf1e |-------------+

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq/aa4ACgkQ+wy+6JSlBuVU0gCdETWcQj9DwZZDDm+dcrczI3po
1+YAnR0GVr6j4694eH82rXlxmwGgqxIm
=5XUX
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
