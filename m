From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 20:09:00 +0100
Message-ID: <20081212190900.GL5691@genesis.frugalware.org>
References: <20081212185347.GK5691@genesis.frugalware.org> <20081212182827.28408.40963.stgit@warthog.procyon.org.uk> <28996.1229108561@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JMKEfAmnQy+WzDHS"
Cc: torvalds@osdl.org, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 20:10:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBDP6-0002Um-DV
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 20:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYLLTJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 14:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYLLTJE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 14:09:04 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46694 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbYLLTJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 14:09:03 -0500
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Dec 2008 14:09:03 EST
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DD6E2580AD;
	Fri, 12 Dec 2008 20:09:00 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CB2AD4465E;
	Fri, 12 Dec 2008 20:09:00 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 90D3811B885F; Fri, 12 Dec 2008 20:09:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <28996.1229108561@redhat.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102928>


--JMKEfAmnQy+WzDHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2008 at 07:02:41PM +0000, David Howells <dhowells@redhat.co=
m> wrote:
> > Is there any reason you hide the tag object?
>=20
> What's a tag object?

http://www.kernel.org/pub/software/scm/git/docs/gitglossary.html#def_tag_ob=
ject

> > Using git clone --mirror would be much efficient, I think.
>=20
> 	warthog>man git-clone | grep mirror
> 	warthog1>

It's new in v1.6.0. You can just use git --bare init; git remote
add --mirror in older versions.

--JMKEfAmnQy+WzDHS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklCtswACgkQe81tAgORUJZdQgCgo9MZsAtjMJfHnxE+w2sEZf8G
wX8AnjbECEqU6+VXubsHOOx2NK7Bp42U
=RkPN
-----END PGP SIGNATURE-----

--JMKEfAmnQy+WzDHS--
