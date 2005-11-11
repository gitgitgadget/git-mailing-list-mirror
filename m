From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Change 'cache' to 'index' in the docs
Date: Fri, 11 Nov 2005 15:34:31 +0100
Message-ID: <4374ABF7.1010304@op5.se>
References: <4373EFFB.6060802@etek.chalmers.se> <7voe4svufi.fsf@assigned-by-dhcp.cox.net> <43748566.2070204@op5.se> <Pine.LNX.4.63.0511111514420.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 15:34:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaZzA-0007vS-26
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 15:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKKOed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 09:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVKKOed
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 09:34:33 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:26030 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750794AbVKKOec
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 09:34:32 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 79E496BD0D
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 15:34:31 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0511111514420.7575@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11600>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 11 Nov 2005, Andreas Ericsson wrote:
> 
> 
>>This had me puzzled for quite some time. Some notice to the tutorial about
>>what's meant when it says "tree-ish" or "commit-ish" would be nice (I still
>>haven't been able to figure it out).
> 
> 
> See glossary.txt.
> 

Ahhh. Terminology (here daft ole me was grep'ing away for 
"nomenclature"...). Thanks a million.

Although it would be nice if it was mentioned up top with the other 
"read these first" files.

> 
>>The wording in git-diff-index.txt isn't exactly stellar either.
> 
> 
> Agree. Want to do something about it?
> 

Why not? Usually I can't even understand my own documentation, but it 
might at least raise the discussion.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
