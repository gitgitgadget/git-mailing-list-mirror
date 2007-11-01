From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Document that using -M without other diff options is
	not a good idea
Date: Thu, 1 Nov 2007 16:24:51 +0100
Message-ID: <20071101152451.GI27987@genesis.frugalware.org>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org> <Pine.LNX.4.64.0711011508490.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 01 16:25:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inbus-0003H0-OK
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 16:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbXKAPYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 11:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754138AbXKAPYy
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 11:24:54 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55162 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753848AbXKAPYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 11:24:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5D32F1B2502;
	Thu,  1 Nov 2007 16:24:52 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8D64F44659;
	Thu,  1 Nov 2007 16:24:25 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C9B4D13A40D4; Thu,  1 Nov 2007 16:24:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711011508490.4362@racer.site>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62974>


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 01, 2007 at 03:09:25PM +0000, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> As I remarked on IRC earlier, this will also show up in the man page of=
=20
> git-diff, too.  Rather funny, no?

ah, then i misunderstood you. so the correct way would be to juse ignore
the -M switch if it's useless? my problem is that if you use git log -M
then it's a pointless slowdown and you can't find this in the doc :s

thanks,
- VMiklos

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHKe/De81tAgORUJYRAoElAKCgb3dzyjIvi6KWYsWuOHAHh6gCDQCgpp3a
TXXG2oHUCLAEHPCriu8j1kQ=
=g9dz
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
