From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add help.autocorrect to enable/disable autocorrecting
Date: Fri, 29 Aug 2008 12:11:15 +0200
Message-ID: <48B7CB43.3020808@op5.se>
References: <20080828171533.GA6024@blimp.local> <20080828212722.GF6439@steel.home> <20080828212815.GG6439@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 12:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ0xq-0002YY-8v
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 12:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYH2KLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 06:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbYH2KLR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 06:11:17 -0400
Received: from mail.op5.se ([193.201.96.20]:58982 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbYH2KLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 06:11:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0319F1B800A6;
	Fri, 29 Aug 2008 12:16:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dT5gGZEU6LSK; Fri, 29 Aug 2008 12:16:09 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id A85701B80005;
	Fri, 29 Aug 2008 12:16:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080828212815.GG6439@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen wrote:
> It is off(0) by default, to avoid scaring people unless they asked to.
> If set to a non-0 value, wait for that amount of deciseconds before
> running the corrected command.
> 
> Suggested by Junio, so he has a chance to hit Ctrl-C.
> 

I'm just plain loving this :)

Liked-by: Andreas Ericsson <ae@op5.se>

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
