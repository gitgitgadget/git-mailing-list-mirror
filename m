From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [parse-options] proposal for merge, take 1
Date: Tue, 16 Oct 2007 10:20:10 +0200
Message-ID: <20071016082010.GD6919@artemis.corp>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="d9ADC0YsG2v16Js0";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:20:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhfM-0003uW-J9
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757100AbXJPIUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbXJPIUN
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:20:13 -0400
Received: from pan.madism.org ([88.191.52.104]:47589 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbXJPIUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:20:11 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 779CE25392;
	Tue, 16 Oct 2007 10:20:10 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 21B3A6161; Tue, 16 Oct 2007 10:20:10 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <1192522616-16274-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61115>


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On mar, oct 16, 2007 at 08:16:31 +0000, Pierre Habouzit wrote:
>   The branch is available from git://git.madism.org/git.git in the topic
> branch ph/parseopt. I just rebased it onto the last "next" spearce
> produced.

>       Make builtin-pack-objects.c use parse_options.

  ERRR DON'T TAKE 25/25, it's WIP and is broken atm, format-patch again
hasn't DWIM. It is not pushed to git://git.madism.org/git.git btw.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFHQ6vGr7W6HudhwRAghJAKCQeqFKhcmgO2PsmtYuovyhBEU4ygCfVAur
JT0jG82v+NXVB8O1+s9C0GQ=
=DhMl
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--
