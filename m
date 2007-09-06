From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 3/3] Makefile: Add cache-tree.h to the public headers list
Date: Thu, 6 Sep 2007 04:37:29 +0400
Message-ID: <20070906003729.GB23887@basalt.office.altlinux.org>
References: <20070905232251.GC331@nomad.office.altlinux.org> <7vy7fkfy1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 02:37:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5NJ-00020T-Pp
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbXIFAhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 20:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbXIFAhc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:37:32 -0400
Received: from vhq.altlinux.org ([194.107.17.3]:59326 "EHLO
	sendmail.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbXIFAhb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:37:31 -0400
Received: from basalt.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by sendmail.altlinux.org (Postfix) with ESMTP id 348F41B5801C;
	Thu,  6 Sep 2007 04:37:30 +0400 (MSD)
Received: by basalt.office.altlinux.org (Postfix, from userid 501)
	id E6AEDB0D92; Thu,  6 Sep 2007 04:37:29 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <7vy7fkfy1c.fsf@gitster.siamese.dyndns.org>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57791>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2007 at 05:16:47PM -0700, Junio C Hamano wrote:
[...]
> I am however not convinced it is a good idea to treat libgit.a
> as if it is a library.
> It is not a library in the usual sense of the word.

I'd certainly prefer libgit.so with stable interface instead, but
parsecvs needs -lgit now, it cannot wait for "good library".


--=20
ldv

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG30vJfKvmrJ41Nh4RApnQAJ9/tTQgY8IizYChLBLNIYz0TvuG1wCfZfx/
vl61BpPFRN8TMZ7lfy/eCz8=
=BVpl
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
