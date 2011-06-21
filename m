From: Joey Hess <joey@kitenet.net>
Subject: Re: git-union-merge proposal
Date: Tue, 21 Jun 2011 14:41:01 -0400
Message-ID: <20110621184101.GA12108@gnu.kitenet.net>
References: <20110621022049.GA1632@gnu.kitenet.net>
 <7v4o3j9izr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 20:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ5sw-00053K-4T
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 20:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab1FUSlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 14:41:09 -0400
Received: from wren.kitenet.net ([80.68.85.49]:37777 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab1FUSlI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 14:41:08 -0400
Received: from gnu.kitenet.net (dialup-4.153.14.177.Dial1.Atlanta1.Level3.net [4.153.14.177])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 45DDD11841E
	for <git@vger.kernel.org>; Tue, 21 Jun 2011 14:41:06 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 3F6764DE39; Tue, 21 Jun 2011 14:41:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4o3j9izr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176180>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> In other words, I would prefer to see something like:
>=20
> 	$ git merge --index-only [-s <strategy>] <other_branch>

Would this allow merging changes into a branch other than HEAD? If so, I
agree, I'd prefer to see it in git-merge itself if possible.

--=20
see shy jo

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTgDlvMkQ2SIlEuPHAQgdbxAAke0p5davz04LjTjZC90oYSqbXrvtTHC3
XpmHte8FjSphtCeoxKlrkhDu8fw1PwfkE/wt1Rk25fFAYqOwiyPH5Uc++tufwSYS
rZtHFqFd8bTeTQZXdTWyfaMxDkATm+gnyL1U6H9LPlOOGoRy376jtrMFZHOI+QK2
WMFt8vEyhkCmJkJCP8Rfh1ck8UIMqcXMg/aK0esD1cojl230BPVPnBf3Y08AucAG
tGVtei5lmMrytXTb8EDyI9rM6WjjNCOWgfeopgdmVad1wD11W5WLQ8lVMx1wxwsR
9OvtWncAaL/8cCP5S9tZwFe0n7YD1T5xPQI+PLqPmZrCZcxh21WzGnZDVVwwTF1D
0H7KgVsmkj7YamLjMQSfloHl8pK3xWIKlj11FWvHqjT/oIoZ/2Bn8QTwuKQ4Tmv7
6tkZoNXmKC9H23ZQPgAxR61Wp5hPu/rNSWQEVSES0OveB/G0Cttqjf66hBOkJ2Un
s6KUiv8KwzwV7PTGLWY2vOPog5egNeo8yzbRV+VGRx7QG87L36Swnk+HbRj0DB6a
YSoh3QE96wL694W0EvBg6ldLyvM/KGR/SA5ZBNnOd3Z5vTI+doJpfB/4WoaLNzXb
hopXOdmMxq6S3246v9d0ldwkHKYRh57KjgOx4GQ4qo4R4LXJFIfOKack0rF3Mncm
LmVgBY9esz4=
=bv4S
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
