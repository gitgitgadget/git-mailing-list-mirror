X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: 18 Dec 2006 14:21:48 -0800
Message-ID: <86ac1k975v.fsf@blue.stonehenge.com>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181708340.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 22:22:31 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.5; tzolkin = 6 Chicchan; haab = 18 Mac
In-Reply-To: <Pine.LNX.4.64.0612181708340.18171@xanadu.home>
Original-Lines: 21
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34745>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwQrr-00051a-HF for gcvg-git@gmane.org; Mon, 18 Dec
 2006 23:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754663AbWLRWVw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 17:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754685AbWLRWVw
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 17:21:52 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:2886 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754663AbWLRWVv (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 17:21:51 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 50E648F38D; Mon, 18 Dec 2006 14:21:51 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 12110-01-67; Mon, 18 Dec 2006 14:21:48 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id CD5368F391;
 Mon, 18 Dec 2006 14:21:48 -0800 (PST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

>>>>> "Nicolas" == Nicolas Pitre <nico@cam.org> writes:

>> "Indexing" took about 30 seconds.
>> "Resolving 313037 deltas" looks like it's going to take an hour.
>> 
>> So that *was* a local delay.

Nicolas> What CPU and amount of ram do you have?

2.2 Ghz Intel Core 2 Duo (Macbook Pro high end)
I can compile and install GNU Emacs from source in 11 minutes. :)

Nicolas> Are you on Windows?

Gawd no!

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
