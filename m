From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC/PATCH] gitweb: Allow project description in project_index
	file
Date: Fri, 2 May 2008 15:04:56 +0200
Message-ID: <20080502130456.GN23672@genesis.frugalware.org>
References: <200805011220.58871.jnareb@gmail.com> <200805021230.05907.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e8/wErwm0bqugfcz"
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 15:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JruxR-0007m7-Vi
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 15:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759744AbYEBNFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 09:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760851AbYEBNFB
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 09:05:01 -0400
Received: from virgo.iok.hu ([193.202.89.103]:41140 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759714AbYEBNFA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 09:05:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 828A51B2516;
	Fri,  2 May 2008 15:04:58 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 2DCBD4469A;
	Fri,  2 May 2008 15:03:01 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 334121190ACA; Fri,  2 May 2008 15:04:56 +0200 (CEST)
Mail-Followup-To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <200805021230.05907.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80990>


--e8/wErwm0bqugfcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 02, 2008 at 12:30:04PM +0200, Jakub Narebski <jnareb@gmail.com> wrote:
> The reason why it is an RFC is the decision to _not_ URI-decode (to not
> force URI-encoding of e.g. spaces) in the project (repository)
> description part of projects list page.  It makes projects index file
> easier to read and to edit, but it closes possibility of extending this
> format further.  And there is another thing that could be reasonably put
> in this file: future project *categories* support.  So should I try to
> add categories support first?

Just my two cents, I don't think that encoded strings are so unreadable.
Also, having the ability to extend the file later as well would be nice.

--e8/wErwm0bqugfcz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgbEXgACgkQe81tAgORUJYZngCgpDyGsSIT1QTQFhCFmjCGNQjJ
6SgAoJogGIDzHTdHbBNm23GTAyl6TugP
=ofBX
-----END PGP SIGNATURE-----

--e8/wErwm0bqugfcz--
