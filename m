From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [new tool] git-project-version.sh
Date: Tue, 15 Apr 2008 13:05:07 +0100
Message-ID: <20080415120507.GB21572@bit.office.eurotux.com>
References: <20080415113629.GA17459@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080415@schottelius.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 14:06:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JljvF-0005Wq-SZ
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 14:06:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761275AbYDOMFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 08:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759772AbYDOMFQ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 08:05:16 -0400
Received: from os.eurotux.com ([216.75.63.6]:57118 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759288AbYDOMFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 08:05:15 -0400
Received: (qmail 14012 invoked from network); 15 Apr 2008 12:05:12 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 15 Apr 2008 12:05:12 -0000
Content-Disposition: inline
In-Reply-To: <20080415113629.GA17459@denkbrett.schottelius.org>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79594>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2008 at 01:36:29PM +0200, Nico -telmich- Schottelius wrote:
> Hello!
>=20
> As I want to use the latest commit id in all my projects, so I know
> which commit the version is based on, I wrote an extremly simple script
> that is based on git-show to display only the version named
> git-project-version.sh.
>=20
> You can find it in
>    http://unix.schottelius.org/git/git-tools.git/.git/

I couldn't clone:
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

>    http://unix.schottelius.org/cgi-bin/gitweb.cgi?p=3Dgit-tools.git/.git;=
a=3Dsummary
> and more information is available on
>    http://nico.schottelius.org/notizbuch-blog/archive/2008/04/15/git-proj=
ect-version-sh-written-versions-with-git/

I use "git describe" for this, it's more user-friendly.

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFIBJnzinSul6a7oB8RAuv+AJ0WT4y7Mjek41Lz7x8V51+i0v0y3gCgk1wM
guk5ikSHtxVG+G9IP1xvlH0=
=IGvf
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
