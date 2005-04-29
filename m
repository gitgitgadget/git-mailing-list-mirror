From: "Andrew Timberlake-Newell" 
	<Andrew.Timberlake-Newell@AllianceOneInc.com>
Subject: RE: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 16:13:50 -0400
Message-ID: <000e01c54cf7$f61ee4a0$9b11a8c0@allianceoneinc.com>
References: <200504291954.MAA27561@emf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: <seanlkml@sympatico.ca>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:25:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRc2n-0006w4-AU
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVD2UUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbVD2USK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:18:10 -0400
Received: from mail.allianceoneinc.com ([65.213.221.36]:10255 "EHLO
	mail.allianceoneinc.com") by vger.kernel.org with ESMTP
	id S262930AbVD2UPW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:15:22 -0400
Received: from epa20012 [192.168.17.155] by mail.allianceoneinc.com with ESMTP
  (SMTPD32-8.14) id A57E2E3900A8; Fri, 29 Apr 2005 16:13:50 -0400
To: "'Tom Lord'" <lord@emf.net>, <noel@zhtwn.com>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <200504291954.MAA27561@emf.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-IMAIL-SPAM-VALFROM: (957e2e3900a8e1d5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tom Lord responded to Noel Maddy: 
>   > Call me a naive git, but seems to me the "git way" is a little
>   > different. It's tree-based rather than diff-based, and doesn't involve
>   > passing diffs around, right?
> 
> Isn't that a significant part of what I said?  Go back and read more
> carefully, is my suggestion.

It looks to me like he did read carefully.

There were two different ideas:
   TL)  Passing tree & diff and trusting diff to create tree
   NM)  Passing tree and generating diff versus local tree for review

Maybe I'm reading them wrong, but that certainly looks like what each was
expressing and they don't look like the same thing.


