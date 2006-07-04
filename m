From: Bennett Todd <bet@rahul.net>
Subject: git2rss --- publish changes from git-log via RSS
Date: Tue, 4 Jul 2006 19:11:35 +0000
Message-ID: <20060704191135.GB10534@rahul.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
X-From: git-owner@vger.kernel.org Tue Jul 04 21:12:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxqJZ-0002yJ-SG
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 21:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWGDTLy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 15:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWGDTLy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 15:11:54 -0400
Received: from og.latency.net ([64.21.79.2]:49423 "EHLO og.latency.net")
	by vger.kernel.org with ESMTP id S932341AbWGDTLy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 15:11:54 -0400
Received: by og.latency.net (Postfix, from userid 1053)
	id 9CEF013FBCA; Tue,  4 Jul 2006 15:11:53 -0400 (EDT)
Received: from pic.bent.dom (localhost [127.0.0.1])
	by og.latency.net (Postfix) with ESMTP id EE5E913FB2C
	for <git@vger.kernel.org>; Tue,  4 Jul 2006 15:11:50 -0400 (EDT)
Received: (from bet@localhost, uid 500)
          by pic.bent.dom (femail 0.97)
          04 Jul 2006 19:11:35 +0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Spam-Checker-Version: SpamAssassin asr 3.0.2 (2004-11-16) on og.latency.net
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23308>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just switched Bent Linux[1] from darcs to git (darcs is sexy, but I
can build git; ghc defeats me). So I hacked up a quick and simple
git2rss to replace my use of darcs2rss for publishing updates.

<URL:http://bent.latency.net/git2rss>

I hardcoded a couple of Bent-linux-specific bits in there, if
anybody else is actually interested in this, let me know, we can
discuss how to peel 'em out.

I like to read the back archives before posting to a list I've just
subscribed to, but couldn't find a downloadable version of the git
list. If anybody could point me to one, I'd appreciate it.

-Bennett

[1] Bent Linux probably isn't of interest to anybody else, it's my
mid-life crisis project, sound bite "unix as I came to love hear in
the early '80s, when she and I were both much younger, slimmer, and
healthier". uClibc, static linking only, no dynamic loading, no
i18n, nothing gui. Handy for building initrds, perhaps useful for
embedded applications. Nobody but a total crank like me would use it
as their favoured workstation OS.
<URL:http://bent.latency.net/bent/>

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQFEqr1mHZWg9mCTffwRAorbAJ464McRpFG3Zgif//5wIYBoHdxuywCdGmgo
R/xjo5UJvUb8T7LLchAFUPg=
=7/3R
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
