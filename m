From: Tilman Sauerbeck <tilman@code-monkey.de>
Subject: Shipping man pages?
Date: Thu, 18 May 2006 09:46:32 +0200
Message-ID: <20060518074630.GA2994@code-monkey.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
X-From: git-owner@vger.kernel.org Thu May 18 09:46:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgdDU-0007t9-DV
	for gcvg-git@gmane.org; Thu, 18 May 2006 09:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWERHqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 03:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWERHqh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 03:46:37 -0400
Received: from code-monkey.de ([81.169.170.126]:6019 "EHLO code-monkey.de")
	by vger.kernel.org with ESMTP id S1751316AbWERHqh (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 May 2006 03:46:37 -0400
Received: from hammerfest (bwil-d9b966ae.pool.mediaWays.net [217.185.102.174])
	by code-monkey.de (Postfix) with ESMTP id B919578A1
	for <git@vger.kernel.org>; Thu, 18 May 2006 09:46:34 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: mutt-ng/devel-r796 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20270>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
atm, the git release tarballs don't contain man pages. They can be
generated from the asciidoc source files, which makes the build depend
on python and asciidoc.

That's *very* inconvenient; would it be possible to include the man
pages in the release tarball?

Or maybe offer them in a separate tarball?

Thanks,
Tilman

--=20
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing on usenet and in e-mail?

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEbCZW27uLisrW2w8RAqzGAJ97t4WfKHCeuRNjwNsLLbFwG8d1iwCdHRim
/wuhkxuqtQfG1KK+/k9ljj4=
=3vBM
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
