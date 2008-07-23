From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH/RFC] git add: do not add files from a submodule
Date: Wed, 23 Jul 2008 21:11:41 +0200
Message-ID: <20080723191141.GH20614@artemis.madism.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com> <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness> <alpine.DEB.1.00.0807210256510.3305@eeepc-johanness> <alpine.DEB.1.00.0807222230490.8986@racer> <7vhcahgl2j.fsf@gitster.siamese.dyndns.org> <20080723081333.GA15243@artemis.madism.org> <7v8wvse9l7.fsf@gitster.siamese.dyndns.org> <20080723190227.GF20614@artemis.madism.org> <alpine.DEB.1.00.0807232009310.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="UTZ8bGhNySVQ9LYl";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjlT-0001l6-BF
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbYGWTLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbYGWTLn
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:11:43 -0400
Received: from pan.madism.org ([88.191.52.104]:36402 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbYGWTLn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:11:43 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8F88E3A6C2;
	Wed, 23 Jul 2008 21:11:42 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B5FB0464F25; Wed, 23 Jul 2008 21:11:41 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807232009310.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89747>


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2008 at 07:10:09PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 23 Jul 2008, Pierre Habouzit wrote:
>=20
> > Though it'd be great to say e.g. that we won't do a 1.7.0 release[0]=20
> > until we have an UI for submodules we are prood of.
>=20
> Or until we have everything ported over to parse_options?

  hahah, okay, fair enough, I deserve this one ;)

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiHgm0ACgkQvGr7W6HudhzZjwCeIS2/UGcqdwspbCx0aKRPL7JP
lxIAn3MWkyO7XZHW/dWPglTkaZTAm5to
=/dVJ
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
