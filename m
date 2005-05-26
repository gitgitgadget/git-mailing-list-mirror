From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] ls-tree matching a prefix
Date: Thu, 26 May 2005 08:50:41 -0400
Message-ID: <1117111843.11542.11.camel@jmcmullan.timesys>
References: <20050526034756.GA1488@port.evillabs.net> <7vsm0aeguo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	protocol="application/pgp-signature";
	boundary="=-wt1ezH6DdtdXNbNZIIPF";
	micalg=pgp-sha1
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 14:50:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbHnq-00009z-TY
	for gcvg-git@gmane.org; Thu, 26 May 2005 14:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVEZMvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 08:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVEZMvI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 08:51:08 -0400
Received: from mail.timesys.com ([65.117.135.102]:32700 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261413AbVEZMus (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 08:50:48 -0400
Received: from jmcmullan by owa.timesys.com; 26 May 2005 08:50:43 -0400
In-Reply-To: <7vsm0aeguo.fsf@assigned-by-dhcp.cox.net>
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Thu, 26 May 2005 08:44:15 -0400
Message-ID: <1117111843.11542.11.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ls-tree matching a prefix
thread-index: AcVh8KBP5ulAdX9tSt2bGzoFOUvt9w==
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-wt1ezH6DdtdXNbNZIIPF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-05-25 at 21:44 -0700, Junio C Hamano wrote:
> I'd rather see the behaviour match existing commands with path
> restriction, like diff-tree, diff-cache, and diff-files.  That
> is, to take a list of paths and limit your output to those that
> match one of them.  I do not think this enhancement would
> negatively affect your stated use of getting one entry with the
> exact match.

Ok, will do.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-wt1ezH6DdtdXNbNZIIPF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBClcYh8/0vJ5szK6kRAsjKAJ9Wf0WXzGQqZUbGzkvVTJ8n3t8HmgCfYGHM
6DGG8v1flLLyfOpQlHUQvhY=
=qb2o
-----END PGP SIGNATURE-----

--=-wt1ezH6DdtdXNbNZIIPF--
