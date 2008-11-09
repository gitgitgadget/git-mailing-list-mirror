From: Kai Blin <kai@samba.org>
Subject: Re: How it was at GitTogether'08 ?
Date: Sun, 9 Nov 2008 19:55:14 +0100
Message-ID: <200811091955.19304.kai@samba.org>
References: <200811080254.53202.jnareb@gmail.com> <200811091636.55343.kai@samba.org> <200811091731.48694.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart102192390.I9UWbGrqt0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tim Ansell <mithro@mithis.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:56:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzFSe-0006Sn-2l
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 19:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755624AbYKISzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 13:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbYKISzU
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 13:55:20 -0500
Received: from mail.samba.org ([66.70.73.150]:56419 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755617AbYKISzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 13:55:20 -0500
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id 94D16163A72;
	Sun,  9 Nov 2008 18:55:09 +0000 (GMT)
User-Agent: KMail/1.9.10
In-Reply-To: <200811091731.48694.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100462>

--nextPart102192390.I9UWbGrqt0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 09 November 2008 17:31:47 Jakub Narebski wrote:


> The workaround is to put all large files for example in 'media/' folder,
> and make this folder be submodule. Each clone of repository can have
> this 'media' submodule either present (both in object database, although
> usually separate from main project object database), or not present
> (not cloned and not checked out).

Tim was talking about that media/ folder and managing that in git. If you w=
ant=20
to work on the media, you might end up getting hundreds of gigabytes of dat=
a=20
to get that folder, even if you only need to change one single file.

That's the issue we're running into, and I don't thing submodules solve thi=
s=20
at all.

Cheers,
Kai

=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart102192390.I9UWbGrqt0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJFzIXEKXX/bF2FpQRAjAPAJ92sQ5CMjeJAPs5KVRnxiwu/ldX+QCfZFIr
wf6LNbpS6yxK3klCcftDe5c=
=xjah
-----END PGP SIGNATURE-----

--nextPart102192390.I9UWbGrqt0--
