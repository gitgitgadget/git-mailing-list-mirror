From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: commit-tree: remove 16 parents restriction
Date: Fri, 8 Aug 2008 13:41:22 +0200
Message-ID: <200808081341.24451.trast@student.ethz.ch>
References: <1218181975-12093-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0808081238250.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9374822.Nu5KPqMTVm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 13:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRQMM-0003hq-7B
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 13:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312AbYHHLlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 07:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbYHHLlQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 07:41:16 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:13055 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282AbYHHLlP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 07:41:15 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 13:41:13 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 13:41:14 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0808081238250.9611@pacific.mpi-cbg.de.mpi-cbg.de>
X-OriginalArrivalTime: 08 Aug 2008 11:41:14.0123 (UTC) FILETIME=[A9796DB0:01C8F94B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91659>

--nextPart9374822.Nu5KPqMTVm
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
>=20
> On Fri, 8 Aug 2008, Thomas Rast wrote:
>=20
> >  Creates a new commit object based on the provided tree object and
> > -emits the new commit object id on stdout. If no parent is given then
> > -it is considered to be an initial tree.
> > +emits the new commit object id on stdout.
>=20
> Oops.

I deliberately removed that sentence because I wanted to enumerate all
options in the new second paragraph (0, 1, or many), and felt it would
be redundant.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart9374822.Nu5KPqMTVm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkicMOQACgkQqUud07tmzP0z3ACdHbRHj0JDd9xe2bg9Ttahpyzg
vcYAmwT6thhQVsqHsnFSjoRTFU2/toaT
=n6CD
-----END PGP SIGNATURE-----

--nextPart9374822.Nu5KPqMTVm--
