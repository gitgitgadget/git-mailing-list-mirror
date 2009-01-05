From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-apply.
Date: Mon, 5 Jan 2009 21:06:29 +0100
Message-ID: <20090105200629.GX21154@genesis.frugalware.org>
References: <1230387764-11230-1-git-send-email-vmiklos@frugalware.org> <7vvdt5cmu6.fsf@gitster.siamese.dyndns.org> <20090105191222.GA14793@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bRSz5O7DOzi+nSIn"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 21:08:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJvjt-0008Cn-Ta
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 21:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbZAEUGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753712AbZAEUGc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 15:06:32 -0500
Received: from virgo.iok.hu ([212.40.97.103]:54006 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbZAEUGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 15:06:31 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B7012580DB;
	Mon,  5 Jan 2009 21:06:30 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 472B04465E;
	Mon,  5 Jan 2009 21:06:29 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7755C11B8630; Mon,  5 Jan 2009 21:06:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090105191222.GA14793@artemis.corp>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104596>


--bRSz5O7DOzi+nSIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 05, 2009 at 08:12:22PM +0100, Pierre Habouzit <madcoder@debian.=
org> wrote:
> > I still haven't applied and ran the testsuite myself, but these makes me
> > wonder if there isn't a built-in "bit" type support in parse_options().
>=20
> There is.

FYI, in the meantime f26c494 is already in next, using OPT_BIT. :-)

--bRSz5O7DOzi+nSIn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkliaEUACgkQe81tAgORUJZCmQCfbp0aka64dxOWqQxMxZ2FKSMo
Q4AAoJmXMg0PIwFgC5MTfQLUnZJyLyRm
=SdzK
-----END PGP SIGNATURE-----

--bRSz5O7DOzi+nSIn--
