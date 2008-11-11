From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [darcs-users] [ANNOUNCE] darcs-fast-export
Date: Tue, 11 Nov 2008 14:37:40 +0100
Message-ID: <20081111133740.GE24201@genesis.frugalware.org>
References: <20081111015313.GB24201@genesis.frugalware.org> <AC24F62F-9CFC-442D-8744-813F1930C2F7@zooko.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+GDz8FH0cDPsW8g2"
Cc: git@vger.kernel.org, bazaar@lists.canonical.com,
	mercurial@selenic.com, darcs-users@darcs.net
To: zooko <zooko@zooko.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 14:39:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KztSN-0003wI-JS
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 14:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755837AbYKKNho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 08:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755317AbYKKNho
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 08:37:44 -0500
Received: from virgo.iok.hu ([193.202.89.103]:39078 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbYKKNhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 08:37:43 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E0A605809C;
	Tue, 11 Nov 2008 14:37:41 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3588044698;
	Tue, 11 Nov 2008 14:37:41 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1498F119019E; Tue, 11 Nov 2008 14:37:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AC24F62F-9CFC-442D-8744-813F1930C2F7@zooko.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100644>


--+GDz8FH0cDPsW8g2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2008 at 07:39:26PM -0700, zooko <zooko@zooko.com> wrote:
> If you can show an example of the end result differing from the original=
=20
> repo then that is a bug in tailor, and please report it!

Example:

http://git.frugalware.org/gitweb/gitweb.cgi?p=3Dfrugalware-current.git;a=3D=
commit;h=3Db75189e1689d268f7efa4610ff12c48a67221dc0

Original darcs repo:

http://ftp.frugalware.org/pub/archive/other/darcs/frugalware-current/

If you have a look at the history of the tailor darcs repo, you can see
I contributed a number of fixes later to fix these (where 'these' means
the ones which were pointed out by this particular conversion only)
issues.

--+GDz8FH0cDPsW8g2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZiqQACgkQe81tAgORUJYGEACdExyp1zi+dVHDb2ZoWAIEkr3o
19oAoJg7gNCS0gMGwP1v6B9S0KHkk2BF
=Win+
-----END PGP SIGNATURE-----

--+GDz8FH0cDPsW8g2--
