From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-fast-export hg mutt (24M vs 184M)
Date: Thu, 3 May 2007 23:01:12 +0200
Message-ID: <20070503210112.GE3260@artemis>
References: <20070503185623.GA11817@cip.informatik.uni-erlangen.de> <20070503191716.GB11817@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ytoMbUMiTKPMT3hY";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Thu May 03 23:03:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjiSb-0001tl-D5
	for gcvg-git@gmane.org; Thu, 03 May 2007 23:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031345AbXECVD3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 17:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031350AbXECVD2
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 17:03:28 -0400
Received: from postfix1-g20.free.fr ([212.27.60.42]:35911 "EHLO
	postfix1-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031345AbXECVD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 17:03:27 -0400
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 51B5AF0CE06
	for <git@vger.kernel.org>; Thu,  3 May 2007 23:02:14 +0200 (CEST)
Received: from madism.org (olympe.madism.org [82.243.245.108])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 16CB0188D9;
	Thu,  3 May 2007 23:01:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D320F78C8; Thu,  3 May 2007 23:01:12 +0200 (CEST)
Mail-Followup-To: Thomas Glanzmann <thomas@glanzmann.de>,
	GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070503191716.GB11817@cip.informatik.uni-erlangen.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46107>


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2007 at 09:17:16PM +0200, Thomas Glanzmann wrote:
> Hello,
> git-repack -a -d -f got it down to 19M. I missed the -f parameter
> before. Sorry for the noise.

  You may want to use git gc that does that (and a bit more) for you.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGOk2YvGr7W6HudhwRAsk2AJ95nqDYeD8uHF7mW3dku85yRcJ2wACeNDw2
o8ojFeEOxIaOT1pAvx3W1Ak=
=fhsI
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
