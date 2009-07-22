From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: local configuration
Date: Tue, 21 Jul 2009 21:21:47 -0400
Message-ID: <1248225511-sup-7422@ntdws12.chass.utoronto.ca>
References: <33BF73EE-79AB-435F-B35F-E848DD1F3BF3@roalddevries.nl> <20090720114757.GA25657@vidovic>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1248225737-699235-1198-4540-39-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
To: Roald de Vries <rdv@roalddevries.nl>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 22 03:44:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTQsr-0002oB-1h
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 03:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526AbZGVBoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 21:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZGVBo3
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 21:44:29 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:36596 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496AbZGVBo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 21:44:29 -0400
X-Greylist: delayed 1332 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2009 21:44:29 EDT
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:50963 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1MTQXB-0002a7-VC; Tue, 21 Jul 2009 21:22:17 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1MTQXB-0002QL-Sj; Tue, 21 Jul 2009 21:22:17 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n6M1MH7j009317;
	Tue, 21 Jul 2009 21:22:17 -0400
In-reply-to: <20090720114757.GA25657@vidovic>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123730>


--=-1248225737-699235-1198-4540-39-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Nicolas Sebrecht's message of Mon Jul 20 07:47:57 -0400 2009:
> I try to write my conf files as portable as possible. Today, I don't
> need dedicated branches but that's the way I would achieve it.

I store all of my config in a single tree and have bash or emacs
source files selectively after detecting various useful attributes of
the system.  For bash, this includes platform, 'domain' (site) and
machine.  For emacs, this includes version, flavour, etc.  It makes
for a bigger tree, but I can store it all easily and check it out
anywhere.

-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1248225737-699235-1198-4540-39-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFKZmnJ8vuMHY6J9tIRAnsAAJ9RpbfCkb4F9LVDsQuPZucosOE/nQCeJMan
vkcAezK6Gcqxg0ClE41PySw=
=awYh
-----END PGP SIGNATURE-----

--=-1248225737-699235-1198-4540-39-=--
