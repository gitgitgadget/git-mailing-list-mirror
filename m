X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commit f84871 breaks build on OS X
Date: Fri, 8 Dec 2006 06:51:08 -0500
Message-ID: <2EB26FE2-C6AC-4C2E-9586-AD43B1E05175@silverinsanity.com>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com> <81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com> <86ejrbihnr.fsf@blue.stonehenge.com> <7vmz5zqqo7.fsf@assigned-by-dhcp.cox.net> <7virgnqpt5.fsf@assigned-by-dhcp.cox.net> <81b0412b0612072340w6af9df37y25a1d15773a3f8d8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 8 Dec 2006 11:51:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <81b0412b0612072340w6af9df37y25a1d15773a3f8d8@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33690>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GseG4-0001ox-K6 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 12:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S938049AbWLHLvO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 06:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938051AbWLHLvO
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 06:51:14 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41971 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S938049AbWLHLvN (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 06:51:13 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 521631FFD203; Fri,  8 Dec 2006
 11:51:12 +0000 (UTC)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

On Dec 8, 2006, at 2:40 AM, Alex Riesen wrote:
>> Now, I am CLUELESS about what MakeMaker does, but would this
>> help?
>
> Much better.
> Works here. Others?

Perfect!

