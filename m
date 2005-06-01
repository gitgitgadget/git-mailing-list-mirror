From: "McMullan, Jason" <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] One Git To Rule Them All
Date: Wed, 01 Jun 2005 08:07:41 -0400
Message-ID: <1117627661.19629.1.camel@jmcmullan.timesys>
References: <20050601055833.GA14231@port.evillabs.net> <7vis0yr41f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="=-1JIDkKvw4+aLfcfizZra";
	micalg=pgp-sha1;
	protocol="application/pgp-signature"
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 14:06:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdRyY-0005Pe-6C
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 14:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVFAMIL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 08:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVFAMIL
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 08:08:11 -0400
Received: from mail.timesys.com ([65.117.135.102]:13578 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261354AbVFAMHm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 08:07:42 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Received: from jmcmullan by owa.timesys.com; 01 Jun 2005 12:07:42 +0000
In-Reply-To: <7vis0yr41f.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Content-Class: urn:content-classes:message
X-Mailer: Evolution 2.0.4-3mdk 
Date: Wed, 1 Jun 2005 08:00:57 -0400
Message-ID: <1117627661.19629.1.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] One Git To Rule Them All
thread-index: AcVmoZG6qqaUjMB5TryVKtWMSRewEw==
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-1JIDkKvw4+aLfcfizZra
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-31 at 23:21 -0700, Junio C Hamano wrote:
> I think we had this discussion long time ago on the list, and
> instead of using cvs/svn style of "cmd subcmd" syntax, the
> consensus back then was that using "cmd-" prefix without spaces
> is easier for making TAB completion to work (you do not have to
> muck with command specific rules in the readline configuration),
> and this is especially helpful for people who ends up using the
> bare Plumbing. IIUC, the same reason is behind cg-* command set.

But all the git-<mumble> commands are still there, as symlinks to
git. ie 'git-update-cache' and 'git update-cache' both work.

git-<TAB> still works.

Am I missing something here?

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-1JIDkKvw4+aLfcfizZra
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCnaUN8/0vJ5szK6kRAtCLAKDN2v7iZOeoHM4vO2B0qMjqS9qb8QCfVPvv
xxHh8OtooF4VlpHFG/W6CDA=
=s0Fb
-----END PGP SIGNATURE-----

--=-1JIDkKvw4+aLfcfizZra--
