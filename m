From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 25 Jun 2008 09:29:09 +0200
Message-ID: <20080625072909.GJ29404@genesis.frugalware.org>
References: <7vwskfclfs.fsf@gitster.siamese.dyndns.org> <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl> <20080624160224.GA29404@genesis.frugalware.org> <alpine.DEB.1.00.0806241709330.9925@racer> <20080624185403.GB29404@genesis.frugalware.org> <alpine.DEB.1.00.0806242007150.9925@racer> <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <m3fxr2jruy.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wR5ltk+7XKQetEfC"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBPSB-0000r9-KU
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 09:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYFYH3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 03:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbYFYH3M
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 03:29:12 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57271 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbYFYH3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 03:29:11 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 4F2CC1B2542;
	Wed, 25 Jun 2008 09:29:10 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3A4B844697;
	Wed, 25 Jun 2008 09:03:51 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F33661770070; Wed, 25 Jun 2008 09:29:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3fxr2jruy.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86250>


--wR5ltk+7XKQetEfC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2008 at 05:11:44PM -0700, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> What does "git ls-remote server:/home/vmiklos/git/test" invoke on server?=
=20

$ git ls-remote server:/home/vmiklos/git/test
bash: git-upload-pack: command not found
fatal: The remote end hung up unexpectedly

--wR5ltk+7XKQetEfC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhh88UACgkQe81tAgORUJbOcQCdF+LAhQ3nhGDwK5Y8d1X3BIoX
IGoAn0CHZxgRElHxRKz5rjfM8xSMPg7P
=Q8ND
-----END PGP SIGNATURE-----

--wR5ltk+7XKQetEfC--
