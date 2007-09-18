From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [rfc] git submodules howto
Date: Tue, 18 Sep 2007 17:47:34 +0200
Message-ID: <20070918154734.GP19019@genesis.frugalware.org>
References: <20070918105538.GL19019@genesis.frugalware.org> <20070918132940.GC12120@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 17:49:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXfJo-0003gV-Ni
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 17:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760131AbXIRPrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 11:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759763AbXIRPrq
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 11:47:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:36236 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759749AbXIRPro (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 11:47:44 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IXfIa-0002n3-8g
	from <vmiklos@frugalware.org>; Tue, 18 Sep 2007 17:47:43 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A95BC1678012; Tue, 18 Sep 2007 17:47:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070918132940.GC12120@fieldses.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4177]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58621>


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 18, 2007 at 09:29:40AM -0400, "J. Bruce Fields" <bfields@fields=
es.org> wrote:
> > 2) does this worth adding to the documentation? maybe to a .txt under
> > Documentation/howto? or to git-submodule.txt?
>=20
> Could you add it as a new chapter to user-manual.txt (probably just
> after the "git concepts" chapter), and then add links to that chapter
> from git-submodule(1) and gitmodules(5)?

hm, i did not know about the wiki page Michael created yesterday. so i
don't know what's the rule in case: if something is already in the wiki
then should or should not it be added to the 'official docs'?

- VMiklos

--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG7/MWe81tAgORUJYRAkxtAKCEsztwASF9LJCkYvPamweALuLRjACgkwZF
E04WR48J6YzlUanLj6lAju4=
=7zvb
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--
