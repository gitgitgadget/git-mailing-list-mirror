From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: Question concerning merge behavior
Date: Thu, 26 Jul 2012 08:21:26 -0400
Message-ID: <rmiipdapvax.fsf@fnord.ir.bbn.com>
References: <1343302234333-7563780.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Defcon0 <patzer.dennis@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 14:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuNEO-0001Pc-Se
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 14:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109Ab2GZMbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 08:31:48 -0400
Received: from fnord.ir.bbn.com ([192.1.100.210]:63800 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab2GZMbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 08:31:47 -0400
X-Greylist: delayed 620 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2012 08:31:47 EDT
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 990EEB0A8; Thu, 26 Jul 2012 08:21:26 -0400 (EDT)
OpenPGP: id=32611E25
X-Hashcash: 1:20:120726:git@vger.kernel.org::ntpS8KUy4HccLyWp:0000000000000000000000000000000000000000003Z+j
X-Hashcash: 1:20:120726:patzer.dennis@googlemail.com::ntpS8KUy4HccLyWp:0000000000000000000000000000000005eYg
In-Reply-To: <1343302234333-7563780.post@n2.nabble.com> (Defcon0's message of
	"Thu, 26 Jul 2012 04:30:34 -0700 (PDT)")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202258>

--=-=-=
Content-Type: text/plain


I suggest that you read (all of)

  http://www.git-scm.com/book

and then perhaps ask a question based on more understanding of the merge
model and ancestry tracking.   The short answer is that git will work
quite well in terms of conflict management if your development practices
are sane.




--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iEYEARECAAYFAlARNkYACgkQ+vesoDJhHiVxFQCdHURIx8phiJRTiNtG02C7GSo8
1G0AoKTgcKDO1LD8bqSKiIqHZ8N0IGfw
=kiV6
-----END PGP SIGNATURE-----
--=-=-=--
