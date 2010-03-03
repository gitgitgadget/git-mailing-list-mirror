From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: Which VCS besides git?
Date: Wed, 03 Mar 2010 07:48:39 -0500
Message-ID: <1267620460-sup-2115@pinkfloyd.chass.utoronto.ca>
References: <201003021455.52483.karlis.repsons@gmail.com> <m3y6ialn3z.fsf@localhost.localdomain> <201003021622.22196.karlis.repsons@gmail.com> <201003030241.16959.jnareb@gmail.com> <94a0d4531003030358q276a8e9bue086a8ec06aba395@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1267620549-447538-6916-4488-10-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 13:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmo0u-0004z5-Cq
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 13:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab0CCMtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 07:49:12 -0500
Received: from www.cquest.utoronto.ca ([192.82.128.5]:58967 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753639Ab0CCMtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 07:49:10 -0500
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54641 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Nmo0j-0002Oo-Ff
	for git@vger.kernel.org; Wed, 03 Mar 2010 07:49:09 -0500
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Nmo0j-0007Zv-Ec
	for git@vger.kernel.org; Wed, 03 Mar 2010 07:49:09 -0500
In-reply-to: <94a0d4531003030358q276a8e9bue086a8ec06aba395@mail.gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141452>


--=-1267620549-447538-6916-4488-10-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Felipe Contreras's message of Wed Mar 03 06:58:41 -0500 2010:

> change. Instead, they ensure security by signing every piece of data
> about a commit (commit date, author, commit message). So it's possible
> to have multiple commit dates, authors, messages, etc. each signed by
> a different person.

As a side point...

This is also a lot of extra overhead for people to get up and going.
The git approach of guaranteeing integrity by signing tags only is
much better, both because it accomplishes the same thing and because
people can actually use it without having to share keys everywhere.

[I can't get (most) people to use keys for ssh, good luck trying to
get them to do it for version control...]

-Ben

--=-1267620549-447538-6916-4488-10-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFLjlrF8vuMHY6J9tIRAlx2AKC4UUhkLR+XkcNId4JiqHdcRdMQLQCgw1Gf
Rib8cX72BJRXPANMuk3zzhE=
=RU2z
-----END PGP SIGNATURE-----

--=-1267620549-447538-6916-4488-10-=--
