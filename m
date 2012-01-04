From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] write first for-merge ref to FETCH_HEAD first
Date: Tue, 3 Jan 2012 20:03:39 -0400
Message-ID: <20120104000339.GA22662@gnu.kitenet.net>
References: <20111225173901.GA668@gnu.kitenet.net>
 <7vd3bb929n.fsf@alter.siamese.dyndns.org>
 <20111226161656.GB29582@gnu.kitenet.net>
 <7v1urp97mp.fsf@alter.siamese.dyndns.org>
 <7v7h18s5kg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 01:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiEKd-0008TY-O3
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 01:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab2ADADs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 19:03:48 -0500
Received: from wren.kitenet.net ([80.68.85.49]:45779 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244Ab2ADADq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 19:03:46 -0500
Received: from gnu.kitenet.net (dialup-4.152.108.143.Dial1.Atlanta1.Level3.net [4.152.108.143])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id A27D51180B9;
	Tue,  3 Jan 2012 19:03:44 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 989804BD3E; Tue,  3 Jan 2012 19:03:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v7h18s5kg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187906>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Ping? I think this is a good change to go in before 1.7.9.
>=20
> The change broke quite a lot of tests, and I think I've fixed them all.

Signed-off-by: Joey Hess <joey@kitenet.net>

(Hope that's enough!)

--=20
see shy jo

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTwOXW8kQ2SIlEuPHAQhkMg/+LJF1YpARS2/8gGSpsw/QkTE4KHkjlFy4
t/xWSMoXyNhKxQ2D3a/qzwlNvDrYI7JfocBa+Fq/DTY+uChUCByxBPnbSaxk6sWM
4nkElzAx7ZKxLcwc6n/FIj58NEDrsexQKl1rG05k5hsZH66i85LcSw+/S2a0lyZO
QQVvzJfX+QQCnTq/ncjmbvRijErq3YUzlca6zLkcEBQK8qb6m+2NOBRm4WZSWp24
wmAL2M4lvToT1brhchwmCuLANo9nyAM4RQ6WBhYOsRZBL7Zo+MJ2dnJEodn1B3mi
wR5Ax6pmdlPBKr3fagnsDlarZZA3IJebz93f+ykn5a1JBtpy4Fp4XRFjCQoPGhcW
915LFmz/k7x/+rtB+S/CBkdNVZyEO/efC4Ldnr8NfP0mN0SN4R8ZJ7O+Narw4WWr
LMlHWs/F2q8urxz3bBLFQLqrTODV6anLgkEgoRN2deSwHKcpY+yNGoCu5aZ2TAZp
NykestrGn2/bCAY1cHt1zCCfGdK0WgSiPGoVNc1vxCNOMGsPo2LSzhWBHRst8rvU
yKQOtBX+60UrqqgRoA0IRUBmdzuTlAnq/7KxwUzzKX3lrBJUdKs7FVWzi4fBApvg
P1jlrCMDMToPixjRumrRUDufg/E9EZ2/UUGjajty36BvggKH8u3T+wuVkuyWHWry
0rhragNwa6U=
=IKhA
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
