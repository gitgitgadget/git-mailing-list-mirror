From: John Darrington <john@darrington.wattle.id.au>
Subject: Awkward and confusing question in git --send-email
Date: Sat, 23 Apr 2016 20:22:35 +0200
Message-ID: <20160423182235.GA20615@jocasta.intra>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 20:37:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1au2QP-0006pv-Ce
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 20:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbcDWSg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2016 14:36:56 -0400
Received: from de.cellform.com ([88.217.224.109]:53847 "EHLO jocasta.intra"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751806AbcDWSgz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2016 14:36:55 -0400
X-Greylist: delayed 857 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Apr 2016 14:36:55 EDT
Received: from jocasta.intra (localhost [127.0.0.1])
	by jocasta.intra (8.14.4/8.14.4/Debian-8) with ESMTP id u3NIMZmP020671
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sat, 23 Apr 2016 20:22:35 +0200
Received: (from john@localhost)
	by jocasta.intra (8.14.4/8.14.4/Submit) id u3NIMZ29020670
	for git@vger.kernel.org; Sat, 23 Apr 2016 20:22:35 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292304>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Git --send-email poses the question:

 "Who should the emails be sent to (if any)?"

Apart from sounding clumsy (not to mention incorrect grammar), it took me a=
 while to work out what this meant.

I suggest this be changed to :

"To whom should the email be sent (if anyone) ?"

J'

--=20
Avoid eavesdropping.  Send strong encryted email.
PGP Public key ID: 1024D/2DE827B3=20
fingerprint =3D 8797 A26D 0854 2EAB 0285  A290 8A67 719C 2DE8 27B3
See http://sks-keyservers.net or any PGP keyserver for public key.


--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlcbvWsACgkQimdxnC3oJ7OnTQCfX7kkl1gcmLw89q0dTcc62ese
prUAniAdsnjRQXVAI7bQunE8dyMfx9aO
=tn/U
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
