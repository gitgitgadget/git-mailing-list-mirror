From: VMiklos <vmiklos@frugalware.org>
Subject: Re: renaming question
Date: Mon, 20 Aug 2007 04:11:09 +0200
Message-ID: <20070820021109.GB768@genesis.frugalware.org>
References: <03a701c7e28a$87914fc0$0600a8c0@ze4427wm> <87vebbo0f1.fsf@mid.deneb.enyo.de> <03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Cc: git@vger.kernel.org
To: Aaron Gray <angray@beeb.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 04:11:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMwjj-00060h-T7
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 04:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbXHTCLV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbXHTCLU
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 22:11:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46132 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753241AbXHTCLU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 22:11:20 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IMwjb-0007ao-NJ
	from <vmiklos@frugalware.org>; Mon, 20 Aug 2007 04:11:18 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 44ED413A4022; Mon, 20 Aug 2007 04:11:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <03b401c7e28f$3c7304c0$0600a8c0@ze4427wm>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: 1.1
X-ELTE-SpamLevel: s
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=1.1 required=5.9 tests=BAYES_50,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	1.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56165>


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Na Sun, Aug 19, 2007 at 07:32:01PM +0100, Aaron Gray <angray@beeb.net> pisal(a):
>    rename test.c test.cpp *
>    vi test.cpp

>    git rm test.c
>    git add test.cpp

or just git mv test.c test.cpp

- VMiklos

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGyPg9e81tAgORUJYRAg6gAJ909Nd/NShS87hoNvZYD4pko1+H3wCgjsCP
LCU/EMQPbSXHoVdCFlH8Hww=
=mz6T
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
