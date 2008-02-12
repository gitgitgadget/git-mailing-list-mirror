From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-pull documentation: fix linkgit in the --rebase
	option description.
Date: Tue, 12 Feb 2008 01:08:12 +0100
Message-ID: <20080212000812.GF25954@genesis.frugalware.org>
References: <20080211132800.GV25954@genesis.frugalware.org> <alpine.LSU.1.00.0802111514400.3870@racer.site> <20080211182907.GB25954@genesis.frugalware.org> <7vve4v8g2e.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bNOIqPvWVsuhXMpy"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 01:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOihy-00077R-4T
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 01:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbYBLAIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 19:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbYBLAIf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 19:08:35 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34163 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009AbYBLAIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 19:08:34 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JOihG-0003Gf-Rk
	from <vmiklos@frugalware.org>; Tue, 12 Feb 2008 01:08:32 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 67F4F119050E; Tue, 12 Feb 2008 01:08:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vve4v8g2e.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0013]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73608>


--bNOIqPvWVsuhXMpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2008 at 11:10:33AM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> > I see your point and i played with it a bit, no success so far. If it
> > becomes a new paragraph, the linkgit: is not processed. maybe it's an
> > asciidoc bug?
>=20
> You probably meant to do this, then.

ah, great. then i'll send a patch to change git clone -s' NOTE like
this.

thanks,
- VMiklos

--bNOIqPvWVsuhXMpy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHsONse81tAgORUJYRAl8lAJ4xVWPh0zJXiCHIYQGkNS9R7BzzFQCfRktp
Ufy4eJcZ/I6Vo6IFA8gchns=
=EaeB
-----END PGP SIGNATURE-----

--bNOIqPvWVsuhXMpy--
