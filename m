From: "Andrew Timberlake-Newell" 
	<Andrew.Timberlake-Newell@AllianceOneInc.com>
Subject: RE: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 16:57:15 -0400
Message-ID: <001401c54cfe$061375f0$9b11a8c0@allianceoneinc.com>
References: <200504292026.NAA28131@emf.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: <noel@zhtwn.com>, <seanlkml@sympatico.ca>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 23:43:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdG0-0007UN-Ox
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbVD2U7y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVD2U7U
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:59:20 -0400
Received: from mail.allianceoneinc.com ([65.213.221.36]:7689 "EHLO
	mail.allianceoneinc.com") by vger.kernel.org with ESMTP
	id S262978AbVD2U6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:58:07 -0400
Received: from epa20012 [192.168.17.155] by mail.allianceoneinc.com with ESMTP
  (SMTPD32-8.14) id AFAA2AD600B2; Fri, 29 Apr 2005 16:57:14 -0400
To: "'Tom Lord'" <lord@emf.net>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <200504292026.NAA28131@emf.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-IMAIL-SPAM-VALFROM: (9faa2ad600b2e541)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>   > It looks to me like he did read carefully.
> 
>   > There were two different ideas:
>   >   TL)  Passing tree & diff and trusting diff to create tree
>   >   NM)  Passing tree and generating diff versus local tree for review
> 
> Well, I guess *you* didn't read carefully.  I also spoke about the
> value of passing around triples: ancestry, diff, and tree.  The
> question is about linking signatures to things that humans can
> reasonably *intend* and be reasonably held accountable for, hence one
> of the values of signed diffs.  (I cited other practical reasons to
> value signed diffs and use them in specific ways, too.)

I know that you mentioned other things.  That doesn't invalidate that Noel
was talking about your starting point description of how git works and
suggesting that it isn't how git actually works.  The relevance of your
other points depends upon having the base model correct.

You can argue that glass houses are inherently brittle, but why should I
care if mine is already made of bricks instead of glass?  If the model
against which you are arguing is not the model which is used by git, then
the model isn't a relevant basis for claiming problems with git.


