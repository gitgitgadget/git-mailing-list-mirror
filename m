From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 22:47:40 +0200
Message-ID: <20080613204740.GA29404@genesis.frugalware.org>
References: <200806131633.34980.mirko.stocker@hsr.ch> <20080613145010.GU29404@genesis.frugalware.org> <200806132243.36695.m1stocke@hsr.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WztvdvpUifwiUYBM"
Cc: Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <m1stocke@hsr.ch>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:48:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7GCK-0006F1-L1
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 22:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbYFMUrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 16:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYFMUrn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 16:47:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44892 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717AbYFMUrm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 16:47:42 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0E33D1B2530;
	Fri, 13 Jun 2008 22:47:41 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5DB8D44698;
	Fri, 13 Jun 2008 22:28:48 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CD92B1770022; Fri, 13 Jun 2008 22:47:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200806132243.36695.m1stocke@hsr.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84940>


--WztvdvpUifwiUYBM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2008 at 10:43:36PM +0200, Mirko Stocker <m1stocke@hsr.ch> w=
rote:
> > Don't you mean origin/master?
>=20
> Hm, I'm not sure.. if I work on an a feature in a branch, and now I want =
to=20
> create a patch that applies to the CVS head, then I have to make the diff=
 to=20
> origin/origin, right?

'origin/origin' means the 'origin' branch of the 'origin' remote. Given
that you said you created the 'origin' remote's repo using
git-cvsimport, I assumed that the 'origin' remote has only one branch
(named 'master').

--WztvdvpUifwiUYBM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhS3OwACgkQe81tAgORUJawsgCfagFG0cgLCDt3oc3gnj4r/HRJ
6Z8An2LzGufcf8y8NXQ065dKq7RZiOxx
=8VIQ
-----END PGP SIGNATURE-----

--WztvdvpUifwiUYBM--
