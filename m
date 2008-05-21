From: Nico -telmich- Schottelius <nico-git-20080521@schottelius.org>
Subject: two git-cherry-pick enhancements
Date: Wed, 21 May 2008 18:38:17 +0200
Message-ID: <20080521163817.GA13124@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 18:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyrLS-0007cA-58
	for gcvg-git-2@gmane.org; Wed, 21 May 2008 18:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763379AbYEUQiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 12:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759836AbYEUQiW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 12:38:22 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:59207 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759519AbYEUQiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 12:38:21 -0400
Received: from denkbrett.schottelius.org (natgw.netstream.ch [62.65.128.28])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id BA05D31742B
	for <git@vger.kernel.org>; Wed, 21 May 2008 18:38:13 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 2DD38F00F; Wed, 21 May 2008 18:38:17 +0200 (CEST)
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82555>


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

When using git-cherry-pick there are two things missing for me and just
wondered how you see it (or maybe have a good solution):

- Apply only parts of the patch which applies to <file ...>:
   I sometimes want to apply patches only to some, but not all
   files the patch introduces

- Interactively selecting which parts to apply:
   I want only 7 out of 10 changes the patch introduces.
   It would help alot, if I could choose which parts I want
   to apply for every part of the patch.

Anything planned like that or did I oversee the right way?

Sincerly

Nico

P.S.: Please CC me on reply, I am not subscribed.

--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFINE/5uL75KpiFGIwRAoqLAKCHmskiXXdCIxBhAUi6Daj5CYIGQACeIoxF
ZmlUQsUiMYJPEci53WSWguQ=
=wMId
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
