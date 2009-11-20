From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: GIT 1.5.4.2 installation on Solaris 8 problems
Date: Fri, 20 Nov 2009 14:26:41 -0500
Message-ID: <1258744985-sup-932@ntdws12.chass.utoronto.ca>
References: <loom.20091120T194807-826@post.gmane.org> <1258743998-sup-86@ntdws12.chass.utoronto.ca> <loom.20091120T201341-834@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1258745201-134878-23947-2256-98-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Derek <darek.dade@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 20:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBZ84-0006Rh-Dm
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 20:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753644AbZKTT0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 14:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbZKTT0g
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 14:26:36 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:42842 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbZKTT0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 14:26:35 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:39210 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1NBZ7x-00069K-8n; Fri, 20 Nov 2009 14:26:41 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1NBZ7x-0001yI-6H; Fri, 20 Nov 2009 14:26:41 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id nAKJQf1p007578;
	Fri, 20 Nov 2009 14:26:41 -0500
In-reply-to: <loom.20091120T201341-834@post.gmane.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133369>


--=-1258745201-134878-23947-2256-98-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Derek's message of Fri Nov 20 14:15:40 -0500 2009:
> Unfortunately I need 1.5.4.2 version specifically as I want it to work with
> gibak - http://eigenclass.org/hiki/gibak-backup-system-introduction

Ok, I can't help then.  We have archival versions of older git
packages, but the first version I published was 1.6.0.5.

If you're willing to install the dependency packages, you could build
your own version using the recipe stored in our GAR[1] repository:
http://sourceforge.net/apps/trac/gar/browser/csw/mgar/pkg/git/trunk/Makefile

May help, may not.
-Ben

[1] Basic docs, etc: http://sourceforge.net/apps/trac/gar/
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1258745201-134878-23947-2256-98-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFLBu1x8vuMHY6J9tIRAiSZAJ4nxfUYVr4SrSx5NvHWK0SAQHITiwCaA7mW
FNm32dfx5hFvzTZevPjmfos=
=xMwG
-----END PGP SIGNATURE-----

--=-1258745201-134878-23947-2256-98-=--
