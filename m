From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Documentation/gitcore-tutorial.txt: HEAD not symlink
	these days
Date: Tue, 6 Jan 2009 03:44:43 +0100
Message-ID: <20090106024443.GC21154@genesis.frugalware.org>
References: <1231208319-12673-1-git-send-email-jidanni@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FdZ5NtWbL8qlnu/5"
Cc: git@vger.kernel.org, gitster@pobox.com
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 06 03:46:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK1xS-0003cu-J6
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 03:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbZAFCor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 21:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbZAFCor
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 21:44:47 -0500
Received: from virgo.iok.hu ([212.40.97.103]:37742 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbZAFCoq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 21:44:46 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 26C88580AC;
	Tue,  6 Jan 2009 03:44:46 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 8B1EC4465E;
	Tue,  6 Jan 2009 03:44:44 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id DCF8711B8630; Tue,  6 Jan 2009 03:44:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1231208319-12673-1-git-send-email-jidanni@jidanni.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104622>


--FdZ5NtWbL8qlnu/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2009 at 10:18:39AM +0800, jidanni@jidanni.org wrote:
>  Branches in git are really nothing more than pointers into the git
>  object database from within the `.git/refs/` subdirectory, and as we
> -already discussed, the `HEAD` branch is nothing but a symlink to one of
> +already discussed, the `HEAD` branch is nothing but a pointer to one of
>  these object pointers.

The currect term for HEAD is a 'symref', see the glossary. ;-)

--FdZ5NtWbL8qlnu/5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklixZsACgkQe81tAgORUJZMcACeKtmIF0YzdQ+w0/10UvS3b1uW
M4MAn3KuQ+O+IR8ps6lpx4MkCXpKtXOz
=zsiZ
-----END PGP SIGNATURE-----

--FdZ5NtWbL8qlnu/5--
