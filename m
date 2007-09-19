From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 4/5] Full rework of quote_c_style and write_name_quoted.
Date: Wed, 19 Sep 2007 10:21:11 +0200
Message-ID: <20070919082111.GB28205@artemis.corp>
References: <20070918223947.GB4535@artemis.corp> <20070918224122.2B55D344AB3@madism.org> <46F0C3AB.8010801@op5.se> <20070919080030.GA28205@artemis.corp> <46F0D8E2.5090706@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="kXdP64Ggrk/fb43R";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Sep 19 10:21:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXuoB-0000Wi-M9
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 10:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbXISIVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 04:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbXISIVO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 04:21:14 -0400
Received: from pan.madism.org ([88.191.52.104]:47056 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536AbXISIVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 04:21:13 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 49A9057F;
	Wed, 19 Sep 2007 10:21:12 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DF97B4CA52; Wed, 19 Sep 2007 10:21:11 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46F0D8E2.5090706@op5.se>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58691>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 19, 2007 at 08:08:02AM +0000, Andreas Ericsson wrote:
> Then perhaps a separate patch for this would have been prudent? I'm not
> against the change per se and I understand the reasoning behind it, but
> it seems to go against Documentation/SubmittingPatches (submit one change
> at a time).

  Yes, the thing is, I wrote it in one piece, and had a _very_ hard time
splitting it. The aggregated patches had almost no chunks, and editing
diffs by hand isn't what I like to do :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8Nv3vGr7W6HudhwRAiZwAJ446z+xkSYaomVpHBzhHdhgqyCFFwCgirO2
JlyF/v6rejydIF7M1v9ya9A=
=Vxsh
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
