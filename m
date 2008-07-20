From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [RFC] Stopping those fat "What's cooking in git.git" threads
Date: Sun, 20 Jul 2008 22:51:25 +0200
Message-ID: <20080720205125.GP10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qgeIJYx8sDYEmUhr"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 22:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKftL-0006bk-QF
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 22:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbYGTUv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 16:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbYGTUv2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 16:51:28 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49325 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbYGTUv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 16:51:27 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4A0EC1B251E
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 22:51:26 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8AB284465E
	for <git@vger.kernel.org>; Sun, 20 Jul 2008 22:11:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0619F177001C; Sun, 20 Jul 2008 22:51:25 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89229>


--qgeIJYx8sDYEmUhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

As far as I remember, it was Petr Baudis who first asked on IRC if
these threads (being so big and deep) are annoying for other people as
well or not.

I think it's just hard to follow the discussion as the subject is
usually not changed, so for example when the subject contains "merge", I
carefully read that mail, but I can easily miss such a mail if it's
still "What's cooking in".

An other problem with deep threads is that it just doesn't fit in one's
screen, so I had to use tricks for example to see if a mail was a reply
to my mail or to some other mail.

So here is what I thought about: What about if everyone (except Junio,
of course) would change the subject _and_ remove the In-Reply-To: header
when replying to those mails?

If those large threads just annoys a few people and most people are
happy with the current situation then sorry for the noise.

Thanks.

--qgeIJYx8sDYEmUhr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiDpU0ACgkQe81tAgORUJbxigCfY3WpLV5fiwfcV25agtfYE5Qg
N70AoIDCoBBu5PXuVYYW0sLqdZDzbBWV
=y8KR
-----END PGP SIGNATURE-----

--qgeIJYx8sDYEmUhr--
