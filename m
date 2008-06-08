From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] A simple script to parse the results from the testcases
Date: Sun, 8 Jun 2008 02:49:28 +0200
Message-ID: <20080608004928.GG29404@genesis.frugalware.org>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com> <1212884291-13847-1-git-send-email-vmiklos@frugalware.org> <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6aeoNhjnQIT/3qlD"
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 02:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K597b-0001JE-Je
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbYFHAtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbYFHAtb
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:49:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48818 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173AbYFHAta (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:49:30 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2A83C1B2509;
	Sun,  8 Jun 2008 02:49:29 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 106CA44698;
	Sun,  8 Jun 2008 02:31:26 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id A3B0C1190ACA; Sun,  8 Jun 2008 02:49:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0806071734h16aa4218md051fbbe9f025f43@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84237>


--6aeoNhjnQIT/3qlD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 08, 2008 at 02:34:25AM +0200, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Awesome, what do you want to do with the other patches?

Nothing? It's your series. :-)

> I mean, this patch on it's own doesn't make a lot of sense, but with
> [1/3] and [3/3] I think it deserves some proper reviewing by the list.

Sure. I would suggest:

1) Remove that ugly /tmp/git-test-results, place it under t/.

2) Resend a series indicating this is no longer a demonstration but a
real series which you want to be included. ;-)

Ah and it's bikesheding, but probably key_value_parser.sh is not the
best name for such a script. Maybe aggregate-results.sh or something
like that.

--6aeoNhjnQIT/3qlD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhLLJgACgkQe81tAgORUJb0ugCeI98s7kNV9UZWNsSnTLsnR3vQ
cakAoIYVKzP4aafrATpRFzL9UyQj09nN
=UNkL
-----END PGP SIGNATURE-----

--6aeoNhjnQIT/3qlD--
