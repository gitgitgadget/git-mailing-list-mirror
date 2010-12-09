From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git describe weird behaviour
Date: Thu, 9 Dec 2010 02:33:23 +0100
Message-ID: <20101209013323.GJ22105@genesis.frugalware.org>
References: <20101110010016.GC22105@genesis.frugalware.org>
 <20101110041428.GA8955@sigill.intra.peff.net>
 <20101110140334.GJ22105@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7xmq1vjKKXL+YJuY"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVO8-0005xa-8M
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab0LIBda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 20:33:30 -0500
Received: from virgo.iok.hu ([212.40.97.103]:40834 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701Ab0LIBd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 20:33:29 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 176F758070;
	Thu,  9 Dec 2010 02:33:25 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id C459F44659;
	Thu,  9 Dec 2010 02:33:24 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 683BB132C38D; Thu,  9 Dec 2010 02:33:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101110140334.GJ22105@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163252>


--7xmq1vjKKXL+YJuY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2010 at 03:03:34PM +0100, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> > The patch below implements that in a very rough-and-dirty way. It does
> > find the 1.4 tag in your repository that you expect. However:
>=20
> Yes, works here as well:
>=20
> $ ~/git/git/git describe
> 1.4pre1-210-g48b67cd

Any update on this? I still have this patch in my tree to get correct
git describe output. :)

Thanks.

--7xmq1vjKKXL+YJuY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0AMeMACgkQe81tAgORUJY80QCfYq4vHdHJo37LnzRBPC8U45fY
d5cAnRiT3yHdMsCKyayOP3CAmg3bNfkt
=rqnL
-----END PGP SIGNATURE-----

--7xmq1vjKKXL+YJuY--
