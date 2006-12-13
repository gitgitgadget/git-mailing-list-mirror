X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Move Fink and Ports check to after config file
Date: Tue, 12 Dec 2006 20:35:30 -0500
Message-ID: <7A2E97FA-B419-4F0B-8A21-F0B4FC091BDA@silverinsanity.com>
References: <AF891711-02C9-414F-98CC-BC53DD24EDB3@silverinsanity.com> <7vslfkpwcn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 13 Dec 2006 01:54:59 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 20:54:51 EST
In-Reply-To: <7vslfkpwcn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34177>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuJKg-000580-Qi for gcvg-git@gmane.org; Wed, 13 Dec
 2006 02:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964887AbWLMByv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 20:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWLMByv
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 20:54:51 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41706 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964887AbWLMByv (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 20:54:51 -0500
Received: from [192.168.1.2] (cpe-66-67-221-135.rochester.res.rr.com
 [66.67.221.135]) (using TLSv1 with cipher AES128-SHA (128/128 bits)) (No
 client certificate requested) by silverinsanity.com (Postfix) with ESMTP id
 5F87C1FFCECA; Wed, 13 Dec 2006 01:35:35 +0000 (UTC)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


On Dec 12, 2006, at 5:45 PM, Junio C Hamano wrote:

> First time I saw this today I said "I'd swear I've seen this".
>
> I guess after I asked for a confirmation from you I simply
> forgot to apply it.  Thanks for a reminder.

'salright.  I got so used to "git rebase origin/master" that I forgot  
that I had brought it up.  Oh, well.  Discussing the perl/Makefile  
issue reminded me that I had this sitting in my tree.

