From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 22:47:30 +0200
Message-ID: <200810202247.33372.trast@student.ethz.ch>
References: <200810201010.29173.johan@herland.net> <200810201610.54427.trast@student.ethz.ch> <alpine.LFD.2.00.0810201112360.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart23552419.r8sjpvbEBu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 23:42:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks1gF-0004Yl-96
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 22:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbYJTUrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbYJTUrd
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:47:33 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:33855 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbYJTUrc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:47:32 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 22:47:30 +0200
Received: from pcjremy.inf.ethz.ch ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 20 Oct 2008 22:47:29 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LFD.2.00.0810201112360.26244@xanadu.home>
X-OriginalArrivalTime: 20 Oct 2008 20:47:29.0840 (UTC) FILETIME=[117AB300:01C932F5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98713>

--nextPart23552419.r8sjpvbEBu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Nicolas Pitre wrote:
> On Mon, 20 Oct 2008, Thomas Rast wrote:
> >   http://n.ethz.ch/~trast/download/tmp_pack_NMj69p
>=20
> Yes, except I can't resolve any of the deltas in there...  Is it from=20
> the Linux kernel repository?

No, that was in my own git.git.  Here's the entire repo, if that
context helps.  51M with all temporaries and everything, sorry; I'm
too tired to clean it up.  I doubt I have anything to hide in there
however.

  http://n.ethz.ch/~trast/download/git-with-broken-pack.tar.bz2

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch



--nextPart23552419.r8sjpvbEBu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj87mUACgkQqUud07tmzP0lOACffixj4VdcCqdzf+NtIM+W9RL6
JwMAn1t0yGmnZQTlRiMUFAeakEnodJzW
=pPr+
-----END PGP SIGNATURE-----

--nextPart23552419.r8sjpvbEBu--
