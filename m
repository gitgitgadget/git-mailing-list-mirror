From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: git clone failing over slow links?
Date: Tue, 9 Jun 2009 11:49:18 -0700
Message-ID: <robbat2-20090609T184834-913673685Z@orbis-terrarum.net>
References: <2729632a0906090852r124eff8eo8391ae90cbda5872@mail.gmail.com> <robbat2-20090609T171032-419739557Z@orbis-terrarum.net> <alpine.LFD.2.00.0906091440100.31536@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6OG-0005C0-EA
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436AbZFIStV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbZFIStV
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:49:21 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48101 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754178AbZFIStV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:49:21 -0400
Received: (qmail 15071 invoked from network); 9 Jun 2009 18:49:22 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 09 Jun 2009 18:49:21 +0000
Received: (qmail 22524 invoked by uid 10000); 9 Jun 2009 11:49:18 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906091440100.31536@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121203>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2009 at 02:42:46PM -0400, Nicolas Pitre wrote:
> > For Gentoo, we saw what I think was same problem early on with our
> > conversion experiments. In our case however, it's going to be a
> > non-problem as we intend on disabling initial clone and requiring use of
> > a bundle.
> In the Gentoo case, I think your problem was rather about the memory=20
> usage impact of an initial clone and nothing to do with the speed of the=
=20
> connection.
That was true early on, but it still persists for users on slow
connections.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkourq4ACgkQPpIsIjIzwiw1RQCfb4SqhORtU0m89jxcSEYKwk71
DnsAoOwEGc+ohmfVG20vPCqMahVxGE9y
=9y1N
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
