From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git checkout: add -t alias for --track
Date: Sun, 27 Apr 2008 13:41:52 +0200
Message-ID: <20080427114152.GS4012@genesis.frugalware.org>
References: <20080423230448.GL4012@genesis.frugalware.org> <7vmynfj0a4.fsf@gitster.siamese.dyndns.org> <7v1w4rizlm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DvpQYQy10PodzGf7"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 13:42:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq5HI-00015U-L7
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 13:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbYD0Ll4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 07:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754675AbYD0Ll4
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 07:41:56 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47680 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbYD0Llz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 07:41:55 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8D8841B251D;
	Sun, 27 Apr 2008 13:41:52 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C8BDB44659;
	Sun, 27 Apr 2008 13:38:13 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 478D011904D3; Sun, 27 Apr 2008 13:41:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w4rizlm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80441>


--DvpQYQy10PodzGf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 26, 2008 at 11:25:09PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> What I meant to say was that this may be useful to _some_ degree but
> probably _not very much_.

Yes, it's just about my "having short option aliases are good" idea.
Should I improve the commit message by mentioning that this is useful
"in case you don't want to have branch.autosetupmerge set to true for
some reason"?

--DvpQYQy10PodzGf7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkgUZoAACgkQe81tAgORUJacGQCgmUM75AvaTPElmEOPSN67UtKF
eYAAoJtHZBQhWUFkawWfYLXWh6hUW5tV
=oqSH
-----END PGP SIGNATURE-----

--DvpQYQy10PodzGf7--
