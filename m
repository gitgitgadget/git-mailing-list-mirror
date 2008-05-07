From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/2] Documentation: bisect: add a few "git bisect run"
	examples
Date: Wed, 7 May 2008 09:25:36 +0200
Message-ID: <20080507072536.GJ23672@genesis.frugalware.org>
References: <20080507062931.dd72d7e1.chriscool@tuxfamily.org> <7vwsm6g14i.fsf@gitster.siamese.dyndns.org> <vpqlk2mbpao.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1RkCiX/UEfbG28Bk"
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	Thomas Adam <thomas.adam22@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed May 07 09:26:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jte2p-0004uP-Sq
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 09:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764169AbYEGHZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 03:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755378AbYEGHZn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 03:25:43 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58808 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764169AbYEGHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 03:25:38 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DE78E1B252C;
	Wed,  7 May 2008 09:25:36 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 63C474465E;
	Wed,  7 May 2008 09:21:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 475551190ACB; Wed,  7 May 2008 09:25:36 +0200 (CEST)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Pieter de Bie <pdebie@ai.rug.nl>, Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	Thomas Adam <thomas.adam22@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <vpqlk2mbpao.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81410>


--1RkCiX/UEfbG28Bk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 07, 2008 at 08:29:03AM +0200, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Perhaps also s/~/./g, since it's not a good idea to put temporary
> files in $HOME IMHO.

the point is to have it outside the repo. at least i regularly have 'git
clean -f -x -d' in such a script if i don't trust the upstream build
system. ;)

--1RkCiX/UEfbG28Bk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkghWXAACgkQe81tAgORUJYpfQCffFBnaE16EEPfQtyf6Ru6ACxJ
zdsAn0OAY8aEn4YO7hq+NHTHJ0BWfJb3
=fAcf
-----END PGP SIGNATURE-----

--1RkCiX/UEfbG28Bk--
