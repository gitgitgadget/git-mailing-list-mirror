From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Compiler requirements for git?
Date: Wed, 14 Jan 2009 23:38:32 +0100
Message-ID: <20090114223832.GC30710@genesis.frugalware.org>
References: <128172e70901141032p6e830a85i344d72e1b3bb3a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wqJr86X7F8PBspU2"
Cc: git@vger.kernel.org
To: Corey Stup <coreystup@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEP0-0005yn-B9
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbZANWig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbZANWif
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:38:35 -0500
Received: from virgo.iok.hu ([212.40.97.103]:50294 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596AbZANWie (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:38:34 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 44D8258172;
	Wed, 14 Jan 2009 23:38:34 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B85564465E;
	Wed, 14 Jan 2009 23:38:32 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0A41711B8630; Wed, 14 Jan 2009 23:38:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <128172e70901141032p6e830a85i344d72e1b3bb3a89@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105721>


--wqJr86X7F8PBspU2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 14, 2009 at 01:32:56PM -0500, Corey Stup <coreystup@gmail.com> wrote:
> When trying to compile with a C89 compliant compiler, I'm coming
> across a couple issues:
> - "inline" use

AFAIK that can be avoided with -Dinline=.

--wqJr86X7F8PBspU2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkluaWgACgkQe81tAgORUJaPAgCgj+WLQPjkvWnbTdIx+yQVcOvp
kCcAoKmaFlIitYWbKgtntedPbhXEee/d
=JEOa
-----END PGP SIGNATURE-----

--wqJr86X7F8PBspU2--
