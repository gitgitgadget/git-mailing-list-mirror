From: Nico -telmich- Schottelius <nico-git-20080606@schottelius.org>
Subject: Re: How to compare different files in different branches
Date: Sun, 8 Jun 2008 11:47:54 +0200
Message-ID: <20080608094754.GB1521@denkbrett.schottelius.org>
References: <20080606122421.GA1521@denkbrett.schottelius.org> <20080606123539.GA3119@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 11:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5HWJ-000261-Kx
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 11:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890AbYFHJsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 05:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755494AbYFHJsB
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 05:48:01 -0400
Received: from mx2.schottelius.org ([62.65.138.77]:33458 "EHLO
	mx2.schottelius.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbYFHJsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 05:48:00 -0400
Received: from denkbrett.schottelius.org (77-56-221-77.dclient.hispeed.ch [77.56.221.77])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.schottelius.org (Postfix) with ESMTPSA id 88CF2BF3D3
	for <git@vger.kernel.org>; Sun,  8 Jun 2008 11:47:54 +0200 (CEST)
Received: by denkbrett.schottelius.org (Postfix, from userid 1000)
	id 9970144002; Sun,  8 Jun 2008 11:47:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080606123539.GA3119@mithlond.arda.local>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Unix-Info: http://unix.schottelius.org/
X-Netzseite: http://nico.schottelius.org/
X-System-Info: denkbrett running Linux 2.6.25.3-denkbrett on x86_64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84259>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you all for your fast answers!

I must confess I've overseen -M, as I saw --no-renames and searched
for --renames.

Teemu Likonen [Fri, Jun 06, 2008 at 03:35:39PM +0300]:
> Nico -telmich- Schottelius wrote (2008-06-06 14:24 +0200):
> [...]
> In general form it means:
>=20
>   $ git diff <commit1>:<path1> <commit2>:<path2>
> [...]

Very nice syntax, somehow guessed that this is available, but didn't
try... my fault.=20

Perhaps we should reference git-rev-list(1) from git-diff(1), too?

Sincerly

Nico


--=20
Think about Free and Open Source Software (FOSS).
http://nico.schottelius.org/documentations/foss/the-term-foss/

PGP: BFE4 C736 ABE5 406F 8F42  F7CF B8BE F92A 9885 188C

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIS6rKuL75KpiFGIwRAvMbAJ94cLL0gLm4BFwDgTCwf5L2aZpblACghgtA
rC3RWPgTyKVmwFMaL4N9jEs=
=shqv
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
