From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add/resurrect make uninstall target
Date: Tue, 8 Dec 2009 15:57:15 +0100
Message-ID: <20091208145715.GQ31763@genesis.frugalware.org>
References: <1260283831.1856.43.camel@vuurvlieg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8cfH1LqeFbt1HBOp"
Cc: git <git@vger.kernel.org>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 08 15:57:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI1VD-0005iE-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 15:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755757AbZLHO5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 09:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755449AbZLHO5L
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 09:57:11 -0500
Received: from virgo.iok.hu ([212.40.97.103]:49046 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755253AbZLHO5K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 09:57:10 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id B93A958083;
	Tue,  8 Dec 2009 15:57:15 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id AA0D342F0A;
	Tue,  8 Dec 2009 15:57:15 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7B86F1240011; Tue,  8 Dec 2009 15:57:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260283831.1856.43.camel@vuurvlieg>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134885>


--8cfH1LqeFbt1HBOp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 08, 2009 at 03:50:31PM +0100, Jan Nieuwenhuizen <janneke-list@xs4all.nl> wrote:
>  Makefile           |   18 +++++++++++++++++-
>  gitk-git/Makefile  |    2 ++
>  perl/Makefile      |    2 +-
>  templates/Makefile |    5 +++++
>  4 files changed, 25 insertions(+), 2 deletions(-)

I think the gitk-git one should be a separate patch and then Paul can
apply it to gitk.git.

--8cfH1LqeFbt1HBOp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkseaUsACgkQe81tAgORUJaexQCcCd0zped+RPOdRCDDu5PCF6jp
yzwAn2ITdlaGDfaj2mmmCwqywUDWt7BX
=MOpV
-----END PGP SIGNATURE-----

--8cfH1LqeFbt1HBOp--
