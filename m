From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Implement git clone -v
Date: Tue, 7 Oct 2008 21:39:56 +0200
Message-ID: <20081007193956.GB536@genesis.frugalware.org>
References: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com> <1223331590-22138-1-git-send-email-vmiklos@frugalware.org> <81b0412b0810062321h33abe076kd87b60bffdaf218b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 21:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnIQf-0000zb-Vf
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 21:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbYJGTj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYJGTj6
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 15:39:58 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40290 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753488AbYJGTj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 15:39:58 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5E09D580A8;
	Tue,  7 Oct 2008 21:39:56 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5DEE64465E;
	Tue,  7 Oct 2008 21:39:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3F6F411901A1; Tue,  7 Oct 2008 21:39:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0810062321h33abe076kd87b60bffdaf218b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97743>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2008 at 08:21:28AM +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
> Yes. Does it work? :)

Yes, it does. I'm not sure how to test it from the testsuite, maybe
redirect the output to a file and grep in it? It's ugly, that's why I
did not do so, but if you think a testcase is a musthave for this
feature then that's the way to go, I guess.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjruwwACgkQe81tAgORUJZ6FgCdGlhaO93Z3M8d/9LGjVr8Ct4Z
ZJYAn0RMusagIeOa0aqFwMSDZLE+dl8S
=smRQ
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
