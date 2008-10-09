From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Implement git clone -v
Date: Thu, 9 Oct 2008 23:26:44 +0200
Message-ID: <20081009212644.GX536@genesis.frugalware.org>
References: <20081008060257.GA15240@spearce.org> <1223509232-3520-1-git-send-email-vmiklos@frugalware.org> <7vr66qown3.fsf@gitster.siamese.dyndns.org> <20081009152028.GA29829@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TMgB3/Ch1aWgZB1L"
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 23:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko33B-0006kn-2O
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 23:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337AbYJIV0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 17:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755316AbYJIV0t
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 17:26:49 -0400
Received: from virgo.iok.hu ([193.202.89.103]:50702 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753802AbYJIV0s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 17:26:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5309A5811D;
	Thu,  9 Oct 2008 23:26:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 15DEE4465E;
	Thu,  9 Oct 2008 23:26:45 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id ED45011901A1; Thu,  9 Oct 2008 23:26:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081009152028.GA29829@spearce.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97886>


--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2008 at 08:20:28AM -0700, "Shawn O. Pearce" <spearce@spearc=
e.org> wrote:
> I'm amending the message as the following:
>=20
> --8<--
> Implement git clone -v
>=20
> The new -v option forces the progressbar, even in case the output
> is not a terminal.  This can be useful if the caller is an IDE or
> wrapper which wants to scrape the progressbar from stderr and show
> its information in a different format.

Thanks!

--TMgB3/Ch1aWgZB1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjudxQACgkQe81tAgORUJYIdwCfZbT0jKfKnvVoSlu8Jz/AWsev
PhQAnjVvVz8mOazOXq4WNC7w9FqpFRnS
=9tfo
-----END PGP SIGNATURE-----

--TMgB3/Ch1aWgZB1L--
