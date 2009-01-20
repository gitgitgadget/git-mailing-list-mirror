From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [TOY PATCH] git-resurrect: find traces of a branch name and resurrect it
Date: Tue, 20 Jan 2009 10:01:50 +0100
Message-ID: <200901201001.54979.trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901161213370.3586@pacific.mpi-cbg.de> <1232242703-19086-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901181718370.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2749071.qK2Zm3eBVP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 10:03:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPCVj-0005Li-7M
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 10:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbZATJBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 04:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754575AbZATJBj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 04:01:39 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:25602 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440AbZATJBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 04:01:39 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 10:01:38 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 20 Jan 2009 10:01:37 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.18-0.2-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0901181718370.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 20 Jan 2009 09:01:37.0331 (UTC) FILETIME=[B36BB030:01C97ADD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106459>

--nextPart2749071.qK2Zm3eBVP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

[Sorry for missing this message, it seems KMail4 does have some rather
annoying filtering bugs...]

Johannes Schindelin wrote:
> On Sun, 18 Jan 2009, Thomas Rast wrote:
>=20
> >  Makefile         |    1 +
> >  git-resurrect.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>=20
> Maybe have it in contrib/ instead?

It was really intended as a toy patch, but if people find it useful
(Boyd?) I can add the rest of the options so that all searches can be
chosen independently, and shape it as a "real" contrib patch.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2749071.qK2Zm3eBVP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl1kwIACgkQqUud07tmzP23BACeK41TyVFvAa+711xrNeDq+Yah
G5sAnRsZZr8A3Zpaq1YRV5OmUZdngn57
=O8iM
-----END PGP SIGNATURE-----

--nextPart2749071.qK2Zm3eBVP--
