From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add --only-merges flag to display only merge commits.
Date: Wed, 9 Apr 2008 20:31:42 +0200
Message-ID: <20080409183142.GZ11574@genesis.frugalware.org>
References: <20080408203648.GS11574@genesis.frugalware.org> <alpine.LSU.1.00.0804091605460.10660@wbgn129.biozentrum.uni-wuerzburg.de> <20080409145108.GY11574@genesis.frugalware.org> <alpine.LSU.1.00.0804091659130.10660@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Xp2nimoPFnvF0aLh"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 20:32:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjf5y-0007lC-1W
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 20:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753637AbYDISbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 14:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbYDISbp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 14:31:45 -0400
Received: from virgo.iok.hu ([193.202.89.103]:51533 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752659AbYDISbp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 14:31:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 708981B256D;
	Wed,  9 Apr 2008 20:31:43 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 009AE44659;
	Wed,  9 Apr 2008 20:28:23 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 89F881190A4E; Wed,  9 Apr 2008 20:31:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0804091659130.10660@wbgn129.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79122>


--Xp2nimoPFnvF0aLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2008 at 05:00:14PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > then it'll show only the first merge, --only-merges shows each merge.=
=20
> > (While of course you can still use -1 or tag.. or so.)
>=20
> Yep, I wrote "-1", but what I actually meant was "--no-walk".

Oh, I see. But I still think it would be handy to have an option for
this if there is an option to filter out merges as well.

--Xp2nimoPFnvF0aLh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkf9C44ACgkQe81tAgORUJbbkwCffE+LkDcYM+3hFa+nlipYyVr7
uUAAn24sq0s7ojML07+1EEKtMIbZb7mp
=AIB8
-----END PGP SIGNATURE-----

--Xp2nimoPFnvF0aLh--
