From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Sat, 11 Apr 2009 21:49:25 -0400
Message-ID: <1239500938-sup-5545@ntdws12.chass.utoronto.ca>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca> <20090410093430.6117@nanako3.lavabit.com> <7vmyamdirk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1239500970-775987-21251-5336-63-="; micalg="pgp-sha1"
Cc: GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 12 03:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsouJ-0004f3-KC
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 03:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539AbZDLBte (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 21:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZDLBte
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 21:49:34 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:55970 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbZDLBtd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 21:49:33 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:49545 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Lsop9-0006jj-2u; Sat, 11 Apr 2009 21:49:31 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Lsop9-0006y9-0Q; Sat, 11 Apr 2009 21:49:31 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n3C1nUvk026789;
	Sat, 11 Apr 2009 21:49:30 -0400
In-Reply-To: <7vmyamdirk.fsf@gitster.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116362>


--=-1239500970-775987-21251-5336-63-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Junio C Hamano's message of Sat Apr 11 16:42:39 -0400 2009:
> There was a discussion going that eventurally petered out without seeing
> success (or breakage) reports from people with various platforms.

I didn't see that part of the discussion.  Were there breakage
reports?  I'm willing to make any required corrections to the patch
such that it gets included (then I could drop it locally).

> I think the patch text is Ok, with "where sh is not bash" in the log
> message rephrased to "where sh is not POSIX", but I do not have an
> easy

I'll resubmit with the wording correction and any other requested
alterations.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1239500970-775987-21251-5336-63-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJ4Uiq8vuMHY6J9tIRArI0AJ9hzKy5Q5psTSkQ7R/Wr3e/TgZuGgCg3fHn
XDMhmo1KNbdyb0PBUJZRxDc=
=I5Iq
-----END PGP SIGNATURE-----

--=-1239500970-775987-21251-5336-63-=--
