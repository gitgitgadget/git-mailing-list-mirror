From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 13/14] git-commit-tree: make it usable from other
	builtins
Date: Tue, 1 Jul 2008 14:09:24 +0200
Message-ID: <20080701120924.GV4729@genesis.frugalware.org>
References: <20080701021317.GS4729@genesis.frugalware.org> <666ec9b342a0c3254ae8f917d5bd2dea36314f08.1214878711.git.vmiklos@frugalware.org> <7vbq1irw3q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zu8lIfFVzXMVnfzp"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 14:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDegm-0001Ot-Ib
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 14:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbYGAMJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 08:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYGAMJb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 08:09:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47021 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753705AbYGAMJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 08:09:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2034D1B2516;
	Tue,  1 Jul 2008 14:09:29 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 137B744668;
	Tue,  1 Jul 2008 13:40:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 47C6811901F0; Tue,  1 Jul 2008 14:09:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbq1irw3q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87029>


--zu8lIfFVzXMVnfzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2008 at 10:50:49PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:
>=20
> > This patch is against master, you need to pull from me or first rebase
> > mv/merge-in-c against current master.
>=20
> That's a bad practice.  It makes it much harder to review the incremental
> changes from the previous round.

Sorry. I just did this way because in my patch I wanted to let
cmd_commit_tree() use a commit_list and I saw Dscho already did it, and
I saw that the patch is already in master.

> I'll cope, though.

Thanks.

--zu8lIfFVzXMVnfzp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhqHnQACgkQe81tAgORUJYVYQCfRUt1/KNhDJ1XI7QXRSF/Vo7P
vd8AoIXSg206NgXoC/Pyqj98uBo97Fre
=MWaz
-----END PGP SIGNATURE-----

--zu8lIfFVzXMVnfzp--
