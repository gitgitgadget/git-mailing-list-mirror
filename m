From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase
	--onto
Date: Fri, 6 Jun 2008 16:14:58 +0200
Message-ID: <20080606141458.GQ29404@genesis.frugalware.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mpco6AjI66RzYq4w"
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4cjV-0002P9-Jz
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558AbYFFOPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756423AbYFFOPB
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:15:01 -0400
Received: from virgo.iok.hu ([193.202.89.103]:41434 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716AbYFFOPA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:15:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BB6411B250B;
	Fri,  6 Jun 2008 16:14:58 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CED8F44668;
	Fri,  6 Jun 2008 15:57:13 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 59C671190ACA; Fri,  6 Jun 2008 16:14:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1K4a1Q-0002hq-QE@fencepost.gnu.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84072>


--Mpco6AjI66RzYq4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 06, 2008 at 12:59:30PM +0200, Paolo Bonzini <bonzini@gnu.org> wrote:
> The new strategy resolves only two heads, and the result of the merge
> is always the second head.  It can be useful with `rebase --onto`,
> because it always resolves conflicts in favor of the commits
> being applied.

Just wanted to say I like the idea. :-)

--Mpco6AjI66RzYq4w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhJRmIACgkQe81tAgORUJaT8wCfbLzPbfIlAu5id/9RIGafSxqw
FLwAnA56fYFJ/mYoCtyThhH6j0iEL5QB
=Rlsu
-----END PGP SIGNATURE-----

--Mpco6AjI66RzYq4w--
