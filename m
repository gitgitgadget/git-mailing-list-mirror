From: Ian Campbell <ijc@hellion.org.uk>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 08:20:19 +0100
Message-ID: <1152861620.6977.3.camel@insmouth>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 09:20:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1Hyc-0005rl-AG
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 09:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWGNHUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 14 Jul 2006 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161069AbWGNHUi
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 03:20:38 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:9657 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161066AbWGNHUh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jul 2006 03:20:37 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060714072035.CNHQ15018.mtaout01-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Fri, 14 Jul 2006 08:20:35 +0100
Received: from hopkins.hellion.org.uk ([86.7.20.21])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060714072035.EFQU29849.aamtaout01-winn.ispmail.ntl.com@hopkins.hellion.org.uk>;
          Fri, 14 Jul 2006 08:20:35 +0100
Received: from insmouth.hellion.org.uk ([192.168.1.176])
	by hopkins.hellion.org.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1G1HyL-0005mO-5k; Fri, 14 Jul 2006 08:20:31 +0100
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152835150.31372.23.camel@shinybook.infradead.org>
X-Mailer: Evolution 2.6.2 
X-SA-Exim-Connect-IP: 192.168.1.176
X-SA-Exim-Mail-From: ijc@hellion.org.uk
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on 
	hopkins.hellion.org.uk
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.3
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on hopkins.hellion.org.uk)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23879>

On Fri, 2006-07-14 at 00:59 +0100, David Woodhouse wrote:
> At http://git.kernel.org/git/?p=3Dlinux/kernel/git/dwmw2/kernel-heade=
rs.git
> there's a git tree which contains the sanitised exported headers for =
all
> architectures -- basically the result of 'make headers_install'.
>=20
> It tracks Linus' kernel tree, by means of some evil scripts.=B9
>=20
> Only commits in Linus' tree which actually affect the exported result
> should have an equivalent commit in the above tree, which means that =
any
> changes which affect userspace should be clearly visible for review.

It might be useful to append the commit checksum from Linus' tree to th=
e
comments so it is easier to backtrack to the original commit.

Ian.=20
--=20
Ian Campbell

Your step will soil many countries.
