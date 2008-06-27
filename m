From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: 'next' will be rewound shortly
Date: Fri, 27 Jun 2008 23:36:05 +0200
Message-ID: <20080627213605.GD2058@genesis.frugalware.org>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org> <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org> <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org> <20080627161220.GB6201@leksak.fem-net> <20080627163411.GA2058@genesis.frugalware.org> <20080627171948.GC6201@leksak.fem-net> <20080627192819.GC2058@genesis.frugalware.org> <7vd4m2r2iq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Cc: Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 23:37:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCLd5-00008H-Tr
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 23:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760035AbYF0VgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 17:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758416AbYF0VgK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 17:36:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36897 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758718AbYF0VgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 17:36:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1B90A1B2510;
	Fri, 27 Jun 2008 23:36:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 703BB44697;
	Fri, 27 Jun 2008 23:09:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BEA741778012; Fri, 27 Jun 2008 23:36:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4m2r2iq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86637>


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2008 at 02:28:29PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Following git tradition, manpage came after the command's behaviour has
> been long established.  It will be a behaviour change, and it is open to
> debate if the new behaviour is better or if the proposed change of
> behaviour hurts existing users.

If my opinion counts, I like the current ("prepend") one, and I think
the best would be to add a new option (and/or make it configurable) for
the new ("replace") one.

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhlXUUACgkQe81tAgORUJajEQCgjmpBUPWxffhmEcqFD6nhW8zK
3pMAnRzETh42+JSQpPkz0CmBjRyrA5WP
=tPVN
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
