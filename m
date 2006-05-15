X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sun, 14 May 2006 17:39:13 -0700
Message-ID: <7vbqu0yvda.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
	<7vzmhlsksm.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605131404391.3866@g5.osdl.org>
	<7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605131518390.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 15 May 2006 00:39:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0605131518390.3866@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 13 May 2006 15:39:29 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FfR7G-0008Gx-Sq for gcvg-git@gmane.org; Mon, 15 May
 2006 02:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751307AbWEOAjP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 14 May 2006
 20:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWEOAjP
 (ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 20:39:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:4344 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1751307AbWEOAjP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 14 May 2006 20:39:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127]) by
 fed1rmmtao01.cox.net (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with
 ESMTP id
 <20060515003914.WKPQ19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
 Sun, 14 May 2006 20:39:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 13 May 2006, Junio C Hamano wrote:
>> 
>>  * built-in grep (jc/grep)
>> 
>>    Ready.
>
> I'm not entirely convinced.

I am not either after seeing your numbers and trying them
myself.  I was going to look at it myself over the weekend, but
I ended up spending most of the time migrating my environment,
so no progress on that front yet.  Sorry.


