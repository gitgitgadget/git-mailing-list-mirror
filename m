X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: What's in git.git
Date: Thu, 26 Oct 2006 18:27:39 +0100
Message-ID: <4540F00B.9070504@shadowen.org>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 17:29:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
In-Reply-To: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30248>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd921-0004FO-1k for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423570AbWJZR2T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423698AbWJZR2S
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:28:18 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:47119 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S1423570AbWJZR2R
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:28:17 -0400
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gd911-00032o-LW; Thu, 26 Oct 2006 18:27:39 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

>   I did not hear any comments on the left-right stuff; perhaps
>   it is not needed, or it is not useful as its current shape (it
>   could be enhanced to say which starting commits each of the
>   commit is reachable from, by borrowing much of show-branch
>   code).

That was the stuff which kinda did cherry in rev-list.  It seemed to
produce interesting output, but nothing I couldn't do with cherry.
Still interesting tho.  The sort of thing that if it was in there
someone would find a use for, think lazers.

