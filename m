From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Guided merge with override
Date: Mon, 16 Jun 2008 23:16:38 +0200
Message-ID: <20080616211638.GL29404@genesis.frugalware.org>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com> <20080616092554.GB29404@genesis.frugalware.org> <48563D6C.8060704@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gZ8a79pHZgXqfTok"
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 23:17:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8M53-000339-1y
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 23:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432AbYFPVQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 17:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbYFPVQl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 17:16:41 -0400
Received: from virgo.iok.hu ([193.202.89.103]:54074 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674AbYFPVQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 17:16:41 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 76EA61B253D;
	Mon, 16 Jun 2008 23:16:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id ABAE744698;
	Mon, 16 Jun 2008 22:56:04 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BD84911901F0; Mon, 16 Jun 2008 23:16:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48563D6C.8060704@viscovery.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85234>


--gZ8a79pHZgXqfTok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2008 at 12:16:12PM +0200, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I don't think that's what Geoff needs. The 'theirs' strategy replaces the
> entire tree by 'their' - B's - tree. But IIUC, only the subset of files
> that are contained in B should be replaced by B's version, the rest of the
> files should remain unchanged. This is quite different from 'theirs' strategy.

Thanks, I missed that difference, and sorry for the wrong suggestion.

--gZ8a79pHZgXqfTok
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhW2DYACgkQe81tAgORUJaM7gCfRcQFfweAI5Okx0532xKyxmkM
7tEAoIg32P9+8cM8McWcADUD8DTjBu8P
=JMMp
-----END PGP SIGNATURE-----

--gZ8a79pHZgXqfTok--
