From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git Screencast ?
Date: Thu, 22 Nov 2007 09:23:09 +0100
Message-ID: <47453C6D.1080403@op5.se>
References: <fi1a9f$30q$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Donaghy <mike@mikedonaghy.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7LW-0004a3-05
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbXKVIXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 03:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbXKVIXS
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:23:18 -0500
Received: from mail.op5.se ([193.201.96.20]:34212 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXKVIXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 03:23:18 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EBB901F08050;
	Thu, 22 Nov 2007 09:23:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uua37R0r7Cvv; Thu, 22 Nov 2007 09:23:15 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id B5E3F1F0803B;
	Thu, 22 Nov 2007 09:23:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <fi1a9f$30q$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65750>

Michael Donaghy wrote:
> I am a new user of git and SCMs in general , I have learned a lot from 
> the docs , irc and just using it , but there are just some concepts that 
> hare hard to grasp , I am a very visual persion (probably like a lot of 
> you :) ) , is there a screencast of git somewhere (for free) that can 
> demonstrate some of the advanced features of git...
> (Also...I have seen both Randal (Schwartz) and Linus' (you better know 
> his last name) presentations at google on git , in which they explain 
> the ideas behind git more than the actual usage,
> 

The thing that helped me and my co-workers the most was running through
the steps of the tutorial, but stopping every time something wasn't
absolutely crystal clear and doing gitk or qgit (I prefer qgit, since
it seems to display things more consistently and also loads faster).

That primarily helped us get branches under control. We came from a
CVS world and never had any branches, as none of us had time or energy
to figure out how to merge them back together using those crippled scm's.

I noticed Johannes Gilger already sent you the link to git-for-scientists
thing which is also a really good aid, especially when you've read the
tutorial and some of the less tech-oriented docs.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
