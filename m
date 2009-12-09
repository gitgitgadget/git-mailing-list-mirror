X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Delete particular file contents from complete history
Date: Wed, 9 Dec 2009 22:50:52 +0100
Message-ID: <20091209215052.GG4114@genesis.frugalware.org>
References: <9cdb17250912091001u362ce64fybe3d554304cbc445@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
NNTP-Posting-Date: Wed, 9 Dec 2009 21:51:07 +0000 (UTC)
Cc: git@vger.kernel.org
To: Patrick Grimard <pgrimard@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Content-Disposition: inline
In-Reply-To: <9cdb17250912091001u362ce64fybe3d554304cbc445@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1NIUR2-000416-3r for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009
 22:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756843AbZLIVus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009
 16:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756686AbZLIVus
 (ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 16:50:48 -0500
Received: from virgo.iok.hu ([212.40.97.103]:45320 "EHLO virgo.iok.hu"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1750955AbZLIVur
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 16:50:47 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1]) by virgo.iok.hu
 (Postfix) with ESMTP id 0D4C8580A8; Wed,  9 Dec 2009 22:50:53 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
 by kag.elte.hu (Postfix) with ESMTP id E1C9C42F0A; Wed,  9 Dec 2009 22:50:52
 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000) id
 DF25C1240014; Wed,  9 Dec 2009 22:50:52 +0100 (CET)
Sender: git-owner@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2009 at 01:01:17PM -0500, Patrick Grimard <pgrimard@gmail.com> wrote:
> Is there some way to remove from the entire history a particular
> file's content?

Did you read man git-filter-branch? Looks like the first example does
what you need.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksgG7wACgkQe81tAgORUJa/AQCfbKl8Za6bprWTMgo+sqqW0uVa
n+MAnRtuBtM2cGXlVaAU6ZZAlIAFUFer
=JlLT
-----END PGP SIGNATURE-----

