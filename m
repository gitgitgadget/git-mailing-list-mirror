From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git svn and the post-receive hook
Date: Sat, 2 Aug 2008 22:45:07 +0200
Message-ID: <20080802204507.GA32057@genesis.frugalware.org>
References: <489485BC.1020607@obry.net> <7vwsizl0l9.fsf@gitster.siamese.dyndns.org> <4894B387.4040004@obry.net> <7vod4bdvga.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4R4KJF9m4wUm6hXt"
Cc: pascal@obry.net, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 22:46:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPNzS-0002Gl-FR
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 22:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbYHBUpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 16:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbYHBUpK
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 16:45:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48788 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbYHBUpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 16:45:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 02A061B250D;
	Sat,  2 Aug 2008 22:45:08 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4F23D4465E;
	Sat,  2 Aug 2008 21:58:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7C3351770071; Sat,  2 Aug 2008 22:45:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vod4bdvga.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91174>


--4R4KJF9m4wUm6hXt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 02, 2008 at 01:16:05PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> We might also need to teach push over http (which is not even a second
> class citizen) to trigger post-receive if it does not already do so.

That would be nice, but as far as I understand that is not possible
without ugly hacks like subversion's mod_svn or a CGI script. Or did you
refer to the later?

--4R4KJF9m4wUm6hXt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiUx1MACgkQe81tAgORUJYLVACdE8Q+DydeX/iuuKMNoF2CL/E7
iTQAmwSpsrhxcK0EgN0bnNLaNQaZ3v3A
=lqET
-----END PGP SIGNATURE-----

--4R4KJF9m4wUm6hXt--
