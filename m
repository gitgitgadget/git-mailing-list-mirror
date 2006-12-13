X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sebastian Harl <sh@tokkee.org>
Subject: Re: t9100-git-svn-basic.sh fails
Date: Wed, 13 Dec 2006 09:47:25 +0100
Message-ID: <20061213084724.GO2476@albany.tokkee.org>
References: <20061212232321.GL2476@albany.tokkee.org> <20061213010103.GA18036@localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zBPbvmIlJjvpbu6L"
NNTP-Posting-Date: Wed, 13 Dec 2006 08:47:49 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061213010103.GA18036@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34186>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuPmF-0000kd-4w for gcvg-git@gmane.org; Wed, 13 Dec
 2006 09:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932622AbWLMIr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 03:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWLMIr0
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 03:47:26 -0500
Received: from mail.tokkee.org ([212.114.247.92]:39633 "EHLO
 albany.tokkee.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
 id S932622AbWLMIr0 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 03:47:26 -0500
Received: by albany.tokkee.org (Postfix, from userid 1000) id 5F530364001;
 Wed, 13 Dec 2006 09:47:25 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


--zBPbvmIlJjvpbu6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 12, 2006 at 05:01:03PM -0800, Eric Wong wrote:
> Sebastian Harl <sh@tokkee.org> wrote:
> > When compiling git 1.4.4.2 on my Debian Sarge box t9100-git-svn-basic.s=
h fails
> > with the following output:
> >=20
> >   * FAIL 6: detect node change from directory to file #1
> >          git-svn commit --find-copies-harder --rmdir remotes/git-svn..m=
ybranch2
> >=20
> > I'm using subversion 1.3.2.
> >=20
> > Versions up to 1.4.3.2 built fine.
> >=20
> > Any clues what this might be caused by?
>=20
> Are you using the svn command-line client or are the Perl SVN libraries
> installed?

The Perl SVN libs are installed.

Cheers,
Sebastian

--=20
Sebastian "tokkee" Harl
GnuPG-ID: 0x8501C7FC
http://tokkee.org/


--zBPbvmIlJjvpbu6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFf74cEFEKc4UBx/wRAl6aAJ9OZTGdNScRSp1lPXskA0ttRnb9NgCgi1jZ
4OVQXs8vueguRbNBm/D2p2E=
=hpJK
-----END PGP SIGNATURE-----

