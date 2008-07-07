From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Build in merge
Date: Mon, 7 Jul 2008 19:35:59 +0200
Message-ID: <20080707173559.GU4729@genesis.frugalware.org>
References: <7vej67jt1e.fsf@gitster.siamese.dyndns.org> <1215451460-1681-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IWOW6f13lWWiH/hK"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFue8-00061E-3v
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 19:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbYGGRgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 13:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbYGGRgF
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 13:36:05 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37249 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbYGGRgE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 13:36:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id ECC231B2535;
	Mon,  7 Jul 2008 19:36:01 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EB7CB44698;
	Mon,  7 Jul 2008 19:03:39 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8AD99177001C; Mon,  7 Jul 2008 19:35:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215451460-1681-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87635>


--IWOW6f13lWWiH/hK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 07, 2008 at 07:24:20PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> Here is an updated version without using path_list at all.

Sorry forgot the interdiff and the log:

- interdiff: git diff 2ed1884..10d5724

- log: git log c255d12 (1 commit)

$ git grep -c path.list builtin-merge.c
0

--IWOW6f13lWWiH/hK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyU/8ACgkQe81tAgORUJaCGgCdF+gwN57vspuW8NHxgHKWYA1y
49sAn39v2iqIz1OPtUEx/TWH8Ngl8drk
=utSJ
-----END PGP SIGNATURE-----

--IWOW6f13lWWiH/hK--
