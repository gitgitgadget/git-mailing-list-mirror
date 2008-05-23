From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] [ is explicitly disallowed by bad_ref_char
Date: Fri, 23 May 2008 12:39:06 +0200
Message-ID: <20080523103906.GO27724@genesis.frugalware.org>
References: <a4cc77ec0805230142n7dda9f7ahe4bde3b80f369220@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VOnbToCuTSVGQGT3"
Cc: git@vger.kernel.org
To: Paul Oliver <puzza007@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 12:40:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzUgt-0001o9-Jx
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 12:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbYEWKjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 06:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbYEWKjM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 06:39:12 -0400
Received: from virgo.iok.hu ([193.202.89.103]:34084 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbYEWKjL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 06:39:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1FCB61B250A;
	Fri, 23 May 2008 12:39:07 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 910DC4465E;
	Fri, 23 May 2008 12:25:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id AB12E1778001; Fri, 23 May 2008 12:39:06 +0200 (CEST)
Mail-Followup-To: Paul Oliver <puzza007@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <a4cc77ec0805230142n7dda9f7ahe4bde3b80f369220@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82692>


--VOnbToCuTSVGQGT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2008 at 09:42:04AM +0100, Paul Oliver <puzza007@gmail.com> wrote:
> ---
>  git-cvsimport.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Could you please improve the commit message a bit? Just running git-log
won't let to you know this patch touches git-cvsimport only, which is an
important information here.

--VOnbToCuTSVGQGT3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkg2nsoACgkQe81tAgORUJYlXwCeNKHT55FztNgh+5noxqJT2Eg3
iZMAnjOn5dTz2PSqfJ2zvmJRbhMc54JW
=N2Eu
-----END PGP SIGNATURE-----

--VOnbToCuTSVGQGT3--
