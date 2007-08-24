From: VMiklos <vmiklos@frugalware.org>
Subject: Re: git log vs git diff vs --name-status
Date: Fri, 24 Aug 2007 10:58:19 +0200
Message-ID: <20070824085819.GM31174@genesis.frugalware.org>
References: <20070823084315.GA31174@genesis.frugalware.org> <20070823084512.GB31174@genesis.frugalware.org> <7vr6lutx1p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 10:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOV0D-0004BM-53
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 10:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbXHXI6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 04:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbXHXI6e
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 04:58:34 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:33819 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbXHXI6c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 04:58:32 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IOUzr-0004Fl-SW
	from <vmiklos@frugalware.org>; Fri, 24 Aug 2007 10:58:31 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B94DD1868064; Fri, 24 Aug 2007 10:58:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr6lutx1p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4132]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56564>


--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Na Thu, Aug 23, 2007 at 02:33:38AM -0700, Junio C Hamano <gitster@pobox.com=
> pisal(a):
>  * Anything that is Porcelain should always imply recursive.
>=20
> I am fairly certain about the first one, but not absolutely sure
> about the latter.  The first principle does not justify making
> your example to recurse, but the second, if we accept it, would.

well, i'm not one who should decide this, but i like the idea, i see no
case when not implying recursive in the Porcelain layer can be useful

- VMiklos

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGzp2re81tAgORUJYRAk9CAKCE2WQ7QKWaF17CWnJV2cHtudhl/QCdEUmD
+0zbSy1va2QLxvnIaie6BKk=
=NNyy
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--
