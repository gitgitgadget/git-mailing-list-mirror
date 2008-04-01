From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how do i re-add a file?
Date: Tue, 1 Apr 2008 13:41:47 +0200
Message-ID: <20080401114147.GH3264@genesis.frugalware.org>
References: <47F21814.6000705@tikalk.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jget1-0002qJ-3S
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 13:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754AbYDALlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbYDALlt
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 07:41:49 -0400
Received: from virgo.iok.hu ([193.202.89.103]:18431 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757362AbYDALlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 07:41:49 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 133F41B24F0;
	Tue,  1 Apr 2008 13:41:48 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AA5F344659;
	Tue,  1 Apr 2008 13:38:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C2CA61190A3B; Tue,  1 Apr 2008 13:41:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47F21814.6000705@tikalk.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78652>


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2008 at 02:10:12PM +0300, Ittay Dror <ittayd@tikalk.com> wr=
ote:
> I did git-rm on a file and committed. Made some changes to my sources and=
=20
> committed. Now I want the file back. How can I do that? Related to that,=
=20
> how do I revert my files to some past commit state so that the commits in=
=20
> between are kept in the history?

git checkout HEAD^ -- path/to/file

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkfyH3sACgkQe81tAgORUJY5KgCfcg42LQ1ZNx8fBRwCYxZ2iikl
MwIAoJuuTr6IzjFgzjCn3JlDkeLvkJm7
=aGCK
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
