From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Re* [PATCH] Make git add -u honor --dry-run
Date: Fri, 16 May 2008 02:13:05 +0200
Message-ID: <20080516001305.GR27724@genesis.frugalware.org>
References: <482C5FF8.1060200@isy.liu.se> <1210868459-9511-1-git-send-email-vmiklos@frugalware.org> <7vmymrf81x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3QSQnH4pbmkdUT9"
Cc: Gustaf Hendeby <hendeby@isy.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 02:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwnaD-00007O-4Y
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 02:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYEPANL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 20:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYEPANK
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 20:13:10 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35888 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbYEPANJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 20:13:09 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id CDB981B254B;
	Fri, 16 May 2008 02:13:06 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id A509B4465E;
	Fri, 16 May 2008 02:03:35 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F40DD1770014; Fri, 16 May 2008 02:13:05 +0200 (CEST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vmymrf81x.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82247>


--i3QSQnH4pbmkdUT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 15, 2008 at 04:42:50PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> That makes the whole thing noop, doesn't it?

Exactly. I just considered git add -u --dry-run doing anything a bug.
Then Gustaf pointed out that it would be nice to print the to-be-added
files. Just forget my patch. :)

--i3QSQnH4pbmkdUT9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkgs0ZEACgkQe81tAgORUJaLeQCdF47wv4efjWDd6u3y1n3uI1iT
kFsAnjuBoLIj0OeJOh3D/kyfOtRxffUJ
=TYxd
-----END PGP SIGNATURE-----

--i3QSQnH4pbmkdUT9--
