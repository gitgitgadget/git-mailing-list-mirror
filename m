From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Make bare repository out of git svn init
Date: Wed, 17 Mar 2010 13:58:29 +0100
Message-ID: <20100317125829.GU27414@genesis.frugalware.org>
References: <7fce93be1003170445x4a9d240cv2ca37737d6c7a244@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MdsOjv/FQ+tsWHFo"
Cc: git <git@vger.kernel.org>
To: Sylvain Rabot <sylvain@abstraction.fr>
X-From: git-owner@vger.kernel.org Wed Mar 17 13:58:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrspZ-0002MS-HN
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab0CQM6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 08:58:32 -0400
Received: from virgo.iok.hu ([212.40.97.103]:46905 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab0CQM6c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:58:32 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 17270580B6;
	Wed, 17 Mar 2010 13:58:30 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 040B642F09;
	Wed, 17 Mar 2010 13:58:29 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E5D86124000C; Wed, 17 Mar 2010 13:58:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7fce93be1003170445x4a9d240cv2ca37737d6c7a244@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142392>


--MdsOjv/FQ+tsWHFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 17, 2010 at 12:45:49PM +0100, Sylvain Rabot <sylvain@abstraction.fr> wrote:
> I am interesting if you see things I forgot to do or some use cases
> where those modifications would break anything.

This is what girocco does:

http://repo.or.cz/w/girocco.git/blob/HEAD:/taskd/clone.sh#l25

So it's not necessary to use a tmp non-bare repo as an intermediate
step.

--MdsOjv/FQ+tsWHFo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkug0fUACgkQe81tAgORUJZLngCfS1NbargKxWQoaO6p5eE/WxKC
hP0AoKrEhusgfKPbTx7ScFDJlJE5DEk6
=YI6f
-----END PGP SIGNATURE-----

--MdsOjv/FQ+tsWHFo--
