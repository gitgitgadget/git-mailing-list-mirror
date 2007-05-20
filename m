From: Martin Waitz <tali@admingilde.org>
Subject: Re: RFC: submodule terminology
Date: Mon, 21 May 2007 01:03:54 +0200
Message-ID: <20070520230352.GQ5412@admingilde.org>
References: <20070520214417.GM5412@admingilde.org> <200705210006.47266.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HBg0C3yr6HVa1ZCc"
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 21 01:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuRV-0003Up-6H
	for gcvg-git@gmane.org; Mon, 21 May 2007 01:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757956AbXETXD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 19:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758033AbXETXD4
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 19:03:56 -0400
Received: from mail.admingilde.org ([213.95.32.147]:39895 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757956AbXETXDz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 19:03:55 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HpuRO-00077l-Mz; Mon, 21 May 2007 01:03:54 +0200
Content-Disposition: inline
In-Reply-To: <200705210006.47266.johan@herland.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47948>


--HBg0C3yr6HVa1ZCc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 21, 2007 at 12:06:47AM +0200, Johan Herland wrote:
> For the high-level concept, "subproject" seems to me the best=20
> alternative. I think it is much better than "submodule" at=20
> describing that the subproject is a stand-alone project/repo in
> itself.

it may be developed independently but for the sake of the more important
bigger ("the top level project") it really is only one small part.
That and the fact that "module" is already an established term
in software makes me prefer "submodule".
For me the project is always the top-level one: the project you
currently work for.

> As for the low-level concept, I personally prefer "gitlink", but=20
> I don't have any strong feelings. The fact that "gitlink" seems=20
> to already be used in the code (as in resolve_gitlink_ref() etc.),=20
> coupled with "dirlink" being somewhat ambiguous (i.e. may also be=20
> interpreted as "(sym)link to directory") makes the case for me.

The only problem I have with gitlink is that there already was
a lot of discussion about some entirely different "gitlink", so
choosing a different name is not that bad.
Aside from that I prefer gitlink, too.

--=20
Martin Waitz

--HBg0C3yr6HVa1ZCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGUNPYj/Eaxd/oD7IRAlA0AJ0bbyrhWQDNQrhy+79qA3r4qXXESACdGZrF
itdcMb7C/maYdDQIiwN+HTU=
=ArDm
-----END PGP SIGNATURE-----

--HBg0C3yr6HVa1ZCc--
