From: sean <seanlkml@sympatico.ca>
Subject: Re: Two gitweb feature requests
Date: Fri, 28 Apr 2006 12:26:30 -0400
Message-ID: <BAYC1-PASMTP0240D4E75F0F6EE37BA4EBAEB20@CEZ.ICE>
References: <1146144425.11909.450.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: kay.sievers@vrfy.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 18:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZVs3-0007SA-9J
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 18:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbWD1QbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 12:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbWD1QbD
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 12:31:03 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:38085 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030485AbWD1QbB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 12:31:01 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Apr 2006 09:31:00 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 733FE644C17;
	Fri, 28 Apr 2006 12:30:59 -0400 (EDT)
To: David Woodhouse <dwmw2@infradead.org>
Message-Id: <20060428122630.234edde4.seanlkml@sympatico.ca>
In-Reply-To: <1146144425.11909.450.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Apr 2006 16:31:00.0848 (UTC) FILETIME=[22AB5F00:01C66AE1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Apr 2006 14:27:05 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> First... When publishing trees, I currently give both the git:// URL for
> people who want to pull the tree, and the http:// URL to gitweb for
> those who just want to browse.
> 
> It would be useful if I could get away with giving just one URL --
> probably the http:// one to gitweb. If gitweb were to have a mode in
> which it gave a referral to the git:// URL, and if the git tools would
> use that, then that would work well.

This sounds like a good idea.

> Secondly, it would be useful if gitweb would list the branches in a
> repository and allow each of them to be viewed in the same way as it
> does the master branch.

At the bottom of the Summary page it already lists the branches,
underneath the tags.

Sean
