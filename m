From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Include diff options in the git-log manpage
Date: Tue, 4 Dec 2007 13:28:59 +0100
Message-ID: <20071204122859.GQ31750@genesis.frugalware.org>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org> <1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1RftZa7o64Huaoir"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 13:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzWtx-0002Vp-U6
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 13:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbXLDM3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 07:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752944AbXLDM3E
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 07:29:04 -0500
Received: from virgo.iok.hu ([193.202.89.103]:31235 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752779AbXLDM3D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 07:29:03 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 3AF671B24FC;
	Tue,  4 Dec 2007 13:29:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 628284465D;
	Tue,  4 Dec 2007 13:27:58 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CB80411904C2; Tue,  4 Dec 2007 13:28:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67041>


--1RftZa7o64Huaoir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 03:57:40PM +0100, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> Recently I wanted to see what git log -M does but actually I was not able=
 to
> find it in the manpage, finally figured out that all the diff options are
> missing from here.
>=20
> Removing -p as it's already in diff-options.txt.

could you please have a look at this patch? this also fixes the "-C is
missing from man git-log" issue which was reported on IRC today.

thanks,
- VMiklos

--1RftZa7o64Huaoir
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHVUgLe81tAgORUJYRAmNpAKChMf43I5wLXCv8y/n7XLO2CQs6pACeNxBd
yXddR7c1Zh5c++t/1yIz69I=
=dA7T
-----END PGP SIGNATURE-----

--1RftZa7o64Huaoir--
