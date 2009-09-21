From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: install does not obey DESTDIR or --prefix for perl modules
Date: Mon, 21 Sep 2009 15:40:04 -0400
Message-ID: <1253561929-sup-8931@ntdws12.chass.utoronto.ca>
References: <20090921160551.GD8173@gryning.com> <Ow6bpZou9Vi0tKlyAN-qfjlAAtXvMqpXEAiG54zZ3C8fLI_6_Bt3oA@cipher.nrlssc.navy.mil> <7vskeguqmb.fsf@alter.siamese.dyndns.org> <20090921191943.GE8173@gryning.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1253562008-15804-14146-3322-76-="; micalg="pgp-sha1"
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git <git@vger.kernel.org>
To: c <c@gryning.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 22:12:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MppFP-0004dv-0R
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 22:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbZIUUMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 16:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753262AbZIUUMW
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 16:12:22 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:56846 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbZIUUMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 16:12:21 -0400
X-Greylist: delayed 1903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2009 16:12:21 EDT
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:43483 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Mpok6-0001Ul-Eo; Mon, 21 Sep 2009 15:40:10 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Mpok6-0005ek-CE; Mon, 21 Sep 2009 15:40:10 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n8LJe8Ux021742;
	Mon, 21 Sep 2009 15:40:08 -0400
In-reply-to: <20090921191943.GE8173@gryning.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128910>


--=-1253562008-15804-14146-3322-76-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Craig Taylor's message of Mon Sep 21 15:19:43 -0400 2009:

> Exactly as you describe here, different paths but same goal.
> All binaries follow the DESTDIR path except the perl modules.

I haven't had this problem and I've been packaging git for solaris (8
or newer) since early 2009.  If you're interested in my build notes,
feel free to ping me.

Thanks
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1253562008-15804-14146-3322-76-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFKt9aX8vuMHY6J9tIRAuKkAJ4gtxteYOKUBqLrxjWmjrofgsOrggCg4JHr
zycRUzpCWc9TOEI2uv2aHww=
=xSn+
-----END PGP SIGNATURE-----

--=-1253562008-15804-14146-3322-76-=--
