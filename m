From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 20:55:45 +0200
Message-ID: <20080612185545.GN29404@genesis.frugalware.org>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MY4sEYl+yXp4+5u8"
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ryb-0005Mb-1I
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 20:56:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbYFLSzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 14:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYFLSzy
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 14:55:54 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40214 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbYFLSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 14:55:54 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 0B3931B2517;
	Thu, 12 Jun 2008 20:55:50 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0470444699;
	Thu, 12 Jun 2008 20:37:10 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1CEB81770022; Thu, 12 Jun 2008 20:55:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84771>


--MY4sEYl+yXp4+5u8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2008 at 12:36:43PM -0600, Boyd Lynn Gerber <gerberb@zenez.c=
om> wrote:
> git-svnimport -C /working/git/project /master/svn/pub-svn/category/project

=46rom RelNotes-1.5.4.txt:

 * "git svnimport" was removed in favor of "git svn".  It is still there
   in the source tree (contrib/examples) but unsupported.

Try using git-svn.

--MY4sEYl+yXp4+5u8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhRcTAACgkQe81tAgORUJZggwCdHlSWk1RHeaV+moe7QmrKciNz
JmUAn1zzT2mFDZayBc1c/pFCxJu3+RAQ
=bQS1
-----END PGP SIGNATURE-----

--MY4sEYl+yXp4+5u8--
