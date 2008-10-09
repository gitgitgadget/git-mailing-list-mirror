From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Feature Request: Branch Annotations
Date: Thu, 9 Oct 2008 02:20:19 +0200
Message-ID: <20081009002019.GQ536@genesis.frugalware.org>
References: <d2115f4f0810080341m27c4ca9bv9b1e9b66704ef3fa@mail.gmail.com> <d2115f4f0810080348t62e18b14x1dfe798974332b05@mail.gmail.com> <d2115f4f0810080349o30b6bc2labc2745b8d981e0d@mail.gmail.com> <48ECB5CB.4010703@gmx.net> <7vwsgiptph.fsf@gitster.siamese.dyndns.org> <32541b130810081621k32493e20occba9cd97671775d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bJ3jXuwtxrXxD2iT"
Cc: Junio C Hamano <gitster@pobox.com>,
	David Soria Parra <sn_@gmx.net>,
	Rotem Yaari <vmalloc@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 02:21:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnjHa-00018T-I3
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 02:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbYJIAUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 20:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbYJIAUX
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 20:20:23 -0400
Received: from virgo.iok.hu ([193.202.89.103]:53273 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbYJIAUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 20:20:23 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 05A8D580B5;
	Thu,  9 Oct 2008 02:20:22 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B071E4465E;
	Thu,  9 Oct 2008 02:20:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8A77011901A1; Thu,  9 Oct 2008 02:20:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130810081621k32493e20occba9cd97671775d@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97815>


--bJ3jXuwtxrXxD2iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2008 at 07:21:33PM -0400, Avery Pennarun <apenwarr@gmail.com> wrote:
> I guess bash completions would help with this (if you're using bash),
> but even then it's kind of unreasonable to name branches something
> like "bug-111234-widget-performance-improvements-for-customer-x",

I think you haven't read the links mentioned in the previous mail.

IIRC the thread had a suggestion about creating such a 'desc' branch,
then you could just have a branch named 'fix' and you could do git show
desc:fix to see its description.

Just use git as a filesystem, as it was originally designed... ;-)

--bJ3jXuwtxrXxD2iT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjtTkMACgkQe81tAgORUJavvwCfVZlXX7LLA36zAaX8I9+mkzS0
52YAoIygsObAm3JnfL1IDPt/xM5Mm0bv
=9ymK
-----END PGP SIGNATURE-----

--bJ3jXuwtxrXxD2iT--
