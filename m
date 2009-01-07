From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC PATCH] diff --no-index: test for pager after option
	parsing
Date: Wed, 7 Jan 2009 04:20:13 +0100
Message-ID: <20090107032013.GO21154@genesis.frugalware.org>
References: <1231286163-9422-1-git-send-email-trast@student.ethz.ch> <7vfxjwf041.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f1Ot4QhJn5dlG2/n"
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 04:21:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKOzG-0007yb-EA
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 04:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZAGDUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 22:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbZAGDUQ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 22:20:16 -0500
Received: from virgo.iok.hu ([212.40.97.103]:45141 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751645AbZAGDUP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 22:20:15 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id F30B0580AA;
	Wed,  7 Jan 2009 04:20:14 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 911DB4465E;
	Wed,  7 Jan 2009 04:20:13 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 73C3F11B8630; Wed,  7 Jan 2009 04:20:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxjwf041.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104749>


--f1Ot4QhJn5dlG2/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2009 at 04:09:18PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> But I wonder if it still makes a difference in real life.idn't we stop
> reporting the exit status from the pager some time ago?

I just wanted to write this, I think that code could be just removed
since ea27a18 (spawn pager via run_command interface, 2008-07-22).

--f1Ot4QhJn5dlG2/n
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklkH20ACgkQe81tAgORUJbSFgCgiK07RGtWGNsv43TaVWJK2gEM
sEQAn01P5uyirN4W9K5v77r+GDp+HW7w
=88fA
-----END PGP SIGNATURE-----

--f1Ot4QhJn5dlG2/n--
