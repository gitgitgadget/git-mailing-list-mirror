From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [GSoC] Git projects for Google Summer of Code 2008 final
	evaluation
Date: Fri, 5 Sep 2008 00:55:59 +0200
Message-ID: <20080904225559.GP16514@genesis.frugalware.org>
References: <200809042315.58898.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UuuTb5hZdWr4w/Ub"
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Joshua Roys <roysjosh@gmail.com>,
	Sverre Rabbelier <alturin@gmail.com>,
	Sverre Rabbelier <sverre@rabbelier.nl>,
	David Symonds <dsymonds@gmail.com>,
	Lea Wiemann <LeWiemann@gmail.com>,
	John Hawley <warthog19@eaglescrag.net>,
	Marek Zawirski <marek.zawirski@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 00:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbNlR-0006kV-Cl
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 00:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbYIDW4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 18:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754853AbYIDW4F
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 18:56:05 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58829 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbYIDW4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 18:56:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CA4041B2551;
	Fri,  5 Sep 2008 00:56:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id DBD5A4465E;
	Fri,  5 Sep 2008 00:55:59 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 860061190009; Fri,  5 Sep 2008 00:55:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809042315.58898.jnareb@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94970>


--UuuTb5hZdWr4w/Ub
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2008 at 11:15:56PM +0200, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> 5. git-merge builtin
>=20
> Student: Miklos Vajna
> Mentor: Johannes Schindelin

builtin-merge is merged. I did not have it in my proposal, but support
for custom merge strategies is also merged. Lately I was working on
a better merge-recursive API, that is mostly in next now.

Time did not permit, but I was about to rewrite merge-octopus,
merge-one-file and merge-resolve in C as well.

I hope I'll have time to do it later in my free time, but I can't
promise anything, being a fulltime student as well. ;-)

--UuuTb5hZdWr4w/Ub
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjAZ38ACgkQe81tAgORUJbhgQCeIgUJJAkcfAbQi1vlUm780tSb
h+IAn2BIbfm+6RwKxGp2duYumKwWdZ0e
=Pb5S
-----END PGP SIGNATURE-----

--UuuTb5hZdWr4w/Ub--
