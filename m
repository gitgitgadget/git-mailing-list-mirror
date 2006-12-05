X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Tue, 05 Dec 2006 17:58:07 +0000
Message-ID: <4575B32F.5060108@ramsay1.demon.co.uk>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org> <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org> <7vejri20mf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 5 Dec 2006 18:12:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33360>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GremI-0001Ag-Rn for gcvg-git@gmane.org; Tue, 05 Dec
 2006 19:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968549AbWLESMY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 13:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968552AbWLESMY
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 13:12:24 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:1644 "EHLO
 anchor-post-34.mail.demon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S968549AbWLESMX (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5
 Dec 2006 13:12:23 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196]) by
 anchor-post-34.mail.demon.net with esmtp (Exim 4.42) id 1GremD-000IP6-D3;
 Tue, 05 Dec 2006 18:12:21 +0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin wrote:
> On Fri, 1 Dec 2006, Junio C Hamano wrote:
>> Linus Torvalds <torvalds@osdl.org> writes:
>>> On Thu, 30 Nov 2006, Wink Saville wrote:
>>>> Earlier had a problem with git wanting merge but didn't have it and
>>>> couldn't figure out which package it was in Ubuntu:( So I symlinked merge
>>>> to kdiff3 which worked at the time:
>>> Btw, what's the status of the xdl_merge() thing in "pu"?
>> I haven't looked at the code any further than minimally checking
>> its external interface to be able to interface it with
>> merge-recursive and no more.  Namely:
>>
>>  - I haven't read the algorithm to judge its correctness;
> 
> With my track record of blamable patches, that should be done by somebody 
> else than me.
> 

Have you had time to look at my test cases?
As I said, I found them very useful when debugging
my git-diff3 code, and (hopefully) you will find them
to be equally useful.

> Ciao,
> Dscho
> 

All the best,

Ramsay

