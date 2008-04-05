From: Stephan Beyer <s-beyer@gmx.net>
Subject: rebase--interactive in C vs. sequencer
Date: Sat, 5 Apr 2008 14:22:30 +0200
Message-ID: <20080405122230.GC14565@leksak.fem-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 05 14:23:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji7Qd-00012U-G2
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 14:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbYDEMWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 08:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbYDEMWo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 08:22:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:44091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751660AbYDEMWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 08:22:43 -0400
Received: (qmail invoked by alias); 05 Apr 2008 12:22:42 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp028) with SMTP; 05 Apr 2008 14:22:42 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19QNtohmedQeonQJGG2L4SGgOuLvy0v+3Obj/r+ky
	4EzJFJHCdARfdR
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Ji7Pi-0006pW-E5; Sat, 05 Apr 2008 14:22:30 +0200
Mail-Followup-To: Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78846>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

in [1] you have told that you are working on porting rebase--interactive
to the C programming language.  In reply, Junio pointed out that a
consolidated "git sequencer" is desired.

The sequencer became a project idea for Google Summer of Code and I am
currently applying for that project.  But I had your mail in mind and=20
do not want that any work of yours is thrown away. ;-)
So... what is the current state?
Are you still working on it?
Is there a code stub or even more code which could be used for the
sequencer task?

Regards,
 Stephan

References:
 1. http://marc.info/?l=3Dgit&m=3D120327576215702

--=20
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH928Gbt3SB/zFBA8RAox6AJ9ROBb1rT7Tk9fxx/ws05G3TUFQsACgkDXn
bzXcAiPm5YNC0jV8tqk/1uA=
=5Cpu
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
