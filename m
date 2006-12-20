X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
Date: 20 Dec 2006 14:04:29 -0800
Message-ID: <86vek6z0k2.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 22:05:29 +0000 (UTC)
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
Original-Lines: 16
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34966>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9Yx-0007U1-M9 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030377AbWLTWFU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWLTWFT
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:05:19 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:15000 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030377AbWLTWFS (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:05:18 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 9DE898F5FE; Wed, 20 Dec 2006 14:05:02 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 04744-01; Wed, 20 Dec 2006 14:04:29 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id B03D58F61F;
 Wed, 20 Dec 2006 14:04:29 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> * The 'master' branch has these since the last announcement.
Junio>   They are NOT in 1.4.4.3.

Junio>       index-pack usage of mmap() is unacceptably slower on many OSes
Junio>          other than Linux

Is this really in master?  I'm still seeing one-hour times on
my Mac, using 8336afa563fbeff35e531396273065161181f04c.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
