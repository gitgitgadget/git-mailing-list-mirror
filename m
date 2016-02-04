From: Petr Stodulka <pstodulk@redhat.com>
Subject: COPYING tabs vs whitespaces
Date: Thu, 4 Feb 2016 11:45:46 +0100
Message-ID: <56B32BDA.4010909@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2lMvqMI6vNnGAlKgr0TCkaL7h9W2wRIeq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 11:46:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRHQe-0006hF-FG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 11:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757868AbcBDKqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 05:46:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41323 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979AbcBDKpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 05:45:52 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 0621A5275B
	for <git@vger.kernel.org>; Thu,  4 Feb 2016 10:45:52 +0000 (UTC)
Received: from [10.34.4.171] (unused-4-171.brq.redhat.com [10.34.4.171])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u14Ajowb005102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 4 Feb 2016 05:45:51 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285451>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lMvqMI6vNnGAlKgr0TCkaL7h9W2wRIeq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I found that license file COPYING is different as compared with http://ww=
w.gnu.org/licenses/gpl-2.0.txt
If I pass over with Linus's preamble, change is only about whitespaces - =
tabs vs. space.
Probably it's minor non-essential change, but some projects do this chang=
e, so rather I ask about that.



Regards,
Petr


--2lMvqMI6vNnGAlKgr0TCkaL7h9W2wRIeq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWsyvaAAoJEPiGu5hNgNqPb6IP/jBRECfA2p4q/mAoDMlaUDKH
DPpBk96kJA2YQRAAJG/BJqNddongGdmW1WjPGfl2ifc3ScZ/iIiapObA1aiktO01
xqSdf2PgSb3vGRNBuf8pLb5CfnTxhvCgVp2jFO20poy3tK+4YZIvDMAjMYi5UjEH
Ki4wZA8SMR5sN7tuh/FgebExWgLcFRADdg+y+6XB4xCdEGaZYQyEfpleTb6CaeJG
VkVbzYLhbtMuwZjrtailo0iWOwbWMNPC+nrR1K9nCDiOIY3PdIEhCrSEHBxi5KG9
VVY16HHy6kwyq1BbZiLzfVFiw64iCUuOQLibv+3QlYu22x24c9BbAcjYtzO/W3aa
wKrHdBOOQ0YHWKw41qZV+v1jO3HeCrT+8+Nr50MTNC0Kke9PVngDjQDzfehITjx9
M3v9cdL4wwvCsviELKlfyoziWyoSwdgO7s7EmdQeHkvR1XTEb2IwTAEgpTEr1KgL
tcVKci4Dz5SF44pQkFO76Qv7EXgFPKlLwtTagL/L/+IQjhJvnXEMOZwUfBtg6jS5
skeHqDYw7EK3uHup3CzBK3M9z14wIhrOl14EH78b0vuNoh0AsJ7dxgRrtm8dqgva
Bp0gWTpuqy0fOTAJ/LC7gUfxnTE9n/KxVnyhbt22tK2u/8/fohzK+hBRbsXpxLIx
S89MCCksI73sQA1kiX0/
=A0LO
-----END PGP SIGNATURE-----

--2lMvqMI6vNnGAlKgr0TCkaL7h9W2wRIeq--
