From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 20:33:27 +0100
Message-ID: <20081115193327.GS24201@genesis.frugalware.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <20081114234658.GA2932@spearce.org> <20081115123916.GN24201@genesis.frugalware.org> <7vk5b55ekb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lXBubL3wS507qnlw"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 15 20:34:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Quw-0005Gg-Fd
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 20:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbYKOTdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 14:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYKOTdb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 14:33:31 -0500
Received: from virgo.iok.hu ([193.202.89.103]:58668 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751959AbYKOTda (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 14:33:30 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 63D85580C9;
	Sat, 15 Nov 2008 20:33:29 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 31FCF44698;
	Sat, 15 Nov 2008 20:33:27 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C09B5119019E; Sat, 15 Nov 2008 20:33:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk5b55ekb.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101088>


--lXBubL3wS507qnlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2008 at 05:00:52AM -0800, Junio C Hamano <gitster@pobox.com=
> wrote:
> Under LGPL, you must provide linkable object files to your (possibly
> closed source) program, so that people who made changes to (or obtained an
> updated version of) a LGPL'ed library can re-link your program and use the
> updated library.  The above does not ask you to do so.
>=20
> The way I read LGPL is that "We deeply care about our LGPL library and any
> improvements to it.  Although we do not care at all about how your crappy
> closed source program is written, we want to make sure that the users can
> keep using your program after improvements are made to our library.".  I
> do not think it makes a practical difference when your program uses the
> LGPL library as a shard library from that point of view.

Ah, I see - so this is a "Lesser LGPL". :)

Thank you both Junio and David.

--lXBubL3wS507qnlw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEUEARECAAYFAkkfJAcACgkQe81tAgORUJY5EgCglKIphd6wzda+EuA47Xxv0kO8
RcEAlRhxGq5ZjrvFyCT/eYb+4DUumT4=
=nw6L
-----END PGP SIGNATURE-----

--lXBubL3wS507qnlw--
