From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Who uses Signed-off-by and DCO?
Date: Fri, 12 Jun 2009 07:58:50 -0400
Message-ID: <1244807741-sup-7206@ntdws12.chass.utoronto.ca>
References: <20090612084207.6117@nanako3.lavabit.com> <4A32366A.6090608@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1244807935-73399-6403-5519-5-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
To: Nanako Shiraishi <nanako3@lavabit.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 15:10:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF6Wg-0007oD-4I
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 15:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZFLNJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 09:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbZFLNJF
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 09:09:05 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:35185 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbZFLNJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 09:09:04 -0400
X-Greylist: delayed 4212 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2009 09:09:04 EDT
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:53644 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1MF5PL-0000jg-BX; Fri, 12 Jun 2009 07:58:55 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1MF5PL-0006a1-9D; Fri, 12 Jun 2009 07:58:55 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n5CBwteV025293;
	Fri, 12 Jun 2009 07:58:55 -0400
In-reply-to: <4A32366A.6090608@op5.se>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121420>


--=-1244807935-73399-6403-5519-5-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Andreas Ericsson's message of Fri Jun 12 07:05:14 -0400 2009:
> > I was giving a git introduction to students in my lab, and this
> > question came up from one of them. How widely is this convention
> > used? Are there projects other than the Linux Kernel and git itself?
> > 
> 
> We use it for our own opensource projects, though I must admit we
> stole the idea from git.git.

We're using it for shared admin edits.  The author is root (or
whatever the shared account happens to be in other cases) and the SoB
is the admin that made the change.  It's not enforced by anything
other than convention, but it's still helpful for us.

-Ben

-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1244807935-73399-6403-5519-5-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFKMkL+8vuMHY6J9tIRAhubAJ9OeaVzculH2DjUEoS9sF9SV5ib6wCfSoyP
viewgmLXO8SkKGCcfNpgUmo=
=nsN2
-----END PGP SIGNATURE-----

--=-1244807935-73399-6403-5519-5-=--
