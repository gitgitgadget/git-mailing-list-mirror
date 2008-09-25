From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: having to pull twice
Date: Fri, 26 Sep 2008 01:25:25 +0200
Message-ID: <20080925232525.GP23137@genesis.frugalware.org>
References: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com> <20080925010150.GI3669@spearce.org> <200809250905.09646.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Sep 26 01:26:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj0EF-0000fQ-QV
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 01:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbYIYXZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 19:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbYIYXZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 19:25:27 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59892 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693AbYIYXZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 19:25:26 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CA18C1B24FC;
	Fri, 26 Sep 2008 01:25:25 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 493304465E;
	Fri, 26 Sep 2008 01:25:28 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2180511901A1; Fri, 26 Sep 2008 01:25:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809250905.09646.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96818>


--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 25, 2008 at 09:05:02AM +0200, Thomas Rast <trast@student.ethz.ch> wrote:
> On the other hand, as near as I can tell this is a regression in
> builtin-merge.  Miklos, do you know if/how this can be fixed?

I think Junio already fixed this in 446247d (merge: fix numerus bugs
around "trivial merge" area, 2008-08-23), so 1.6.0.1 or 1.6.0.2 should
not have this bug.

Michael, could you please upgrade frm 1.6.0 and confirm your problem
goes away?

Thanks.

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjcHeUACgkQe81tAgORUJapgQCgkmgiCx/vhEXQcF3XXfjrjFqP
WawAoKLqbzWAZWQhb99xhz8UrMafAscG
=gxwo
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--
