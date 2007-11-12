From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Include diff options in the git-log manpage
Date: Mon, 12 Nov 2007 16:37:17 +0100
Message-ID: <20071112153717.GI5309@genesis.frugalware.org>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org> <1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:37:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbM2-0007zP-2N
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXKLPhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbXKLPhV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:37:21 -0500
Received: from virgo.iok.hu ([193.202.89.103]:33155 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbXKLPhU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:37:20 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D58691B2507;
	Mon, 12 Nov 2007 16:37:17 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7FBD844659;
	Mon, 12 Nov 2007 16:36:39 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7497911901BD; Mon, 12 Nov 2007 16:37:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64639>


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 03:57:40PM +0100, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>=20
> Recently I wanted to see what git log -M does but actually I was not able=
 to
> find it in the manpage, finally figured out that all the diff options are
> missing from here.
>=20
> Removing -p as it's already in diff-options.txt.
>=20
> If this patch OK, then I would like to send a similar patch to
> git-rev-list.txt, too.
>=20
>  Documentation/git-log.txt |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)

could somebody please comment this patch? does it look ok?

thanks,
- VMiklos

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHOHMte81tAgORUJYRAk3iAJ9oQuUZmmmsQLOOOIy8ekj47x+zFgCfea8b
9aDFZftpnL1paEXmlZfSsAM=
=jnFw
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--
