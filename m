From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [rfc] git submodules howto
Date: Tue, 18 Sep 2007 18:11:12 +0200
Message-ID: <20070918161112.GR19019@genesis.frugalware.org>
References: <20070918105538.GL19019@genesis.frugalware.org> <20070918132940.GC12120@fieldses.org> <20070918154734.GP19019@genesis.frugalware.org> <20070918155529.GD18476@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOh8F6DNH/RZBSFD"
Cc: git@vger.kernel.org, Michael Smith <msmith@cbnco.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 18:12:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXffn-00045c-0C
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 18:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759263AbXIRQLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 12:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758995AbXIRQLc
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 12:11:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41769 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758999AbXIRQLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 12:11:31 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IXffT-00057v-Sj
	from <vmiklos@frugalware.org>; Tue, 18 Sep 2007 18:11:25 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 368301678012; Tue, 18 Sep 2007 18:11:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070918155529.GD18476@fieldses.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 0.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.6 required=5.9 tests=BAYES_40,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	0.5 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3355]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58625>


--hOh8F6DNH/RZBSFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[ adding Michael to CC. ]

On Tue, Sep 18, 2007 at 11:55:29AM -0400, "J. Bruce Fields" <bfields@fields=
es.org> wrote:
> > hm, i did not know about the wiki page Michael created yesterday. so i
> > don't know what's the rule in case: if something is already in the wiki
> > then should or should not it be added to the 'official docs'?
>=20
> It should.  We also need submodules documentation for the "official"
> documentation.

okay.

> If you want to base that work off of that wiki page instead of your
> original email, that's fine.  Just make sure you get Michael's
> permission first.

Michael, i think the wiki version is better as my example does not
contain any extra to the wiki version. is it ok if i would send a patch
to include your work in the official docs?

i'm not sure how should i mention you, maybe in the commit message?

- VMiklos

--hOh8F6DNH/RZBSFD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG7/ige81tAgORUJYRArTnAJ4whkrSUWBKzIwSltZiQQRWR/nkTgCgoRCv
lRZimSi5WfjC6jka/z/uFiQ=
=u816
-----END PGP SIGNATURE-----

--hOh8F6DNH/RZBSFD--
