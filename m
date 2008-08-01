From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git help broken
Date: Fri, 1 Aug 2008 16:41:21 +0200
Message-ID: <20080801144121.GU32057@genesis.frugalware.org>
References: <C0DB03B0-8AF5-4B6A-A9DB-16608128EB31@sb.org> <alpine.LSU.1.00.0807310144040.3486@wbgn129.biozentrum.uni-wuerzburg.de> <20080731000454.GJ32057@genesis.frugalware.org> <200808010628.52875.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8hnGVtUCj9jabr6X"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 16:42:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOvpp-0002BF-0C
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 16:42:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYHAOlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 10:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYHAOlX
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 10:41:23 -0400
Received: from virgo.iok.hu ([193.202.89.103]:44359 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYHAOlX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 10:41:23 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 11C4E1B253A;
	Fri,  1 Aug 2008 16:41:22 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E44314465E;
	Fri,  1 Aug 2008 15:54:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 892B71770071; Fri,  1 Aug 2008 16:41:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200808010628.52875.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91071>


--8hnGVtUCj9jabr6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2008 at 06:28:52AM +0200, Christian Couder <chriscool@tuxfa=
mily.org> wrote:
> I didn't realize that the function "is_git_command" would not work=20
> for "help".

Is there any reason why help is not a builtin? I think that would solve
the problem.

I'm willing to do such a patch, I just asked in case that would be
no-go for some - for me - unknown reason.

Thanks.

--8hnGVtUCj9jabr6X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiTIJEACgkQe81tAgORUJZRNgCfYjibmwM8YZ7KI7h3uUoRFEuj
IsAAn3WV6wFWe39MWZvJ4S38pw2gAytI
=Ar8s
-----END PGP SIGNATURE-----

--8hnGVtUCj9jabr6X--
