X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add verbose comments to split_msg()
Date: Tue, 12 Dec 2006 09:20:06 +0100
Message-ID: <457E6636.7010407@op5.se>
References: <200612112212.51533.andyparkins@gmail.com> <7vzm9tzzgt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 08:20:19 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <7vzm9tzzgt.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34066>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu2s4-0002f1-EO for gcvg-git@gmane.org; Tue, 12 Dec
 2006 09:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932142AbWLLIUJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 03:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWLLIUJ
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 03:20:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53289 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932142AbWLLIUI (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006
 03:20:08 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id DA7F46BCBF; Tue, 12 Dec 2006 09:20:06 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Andy Parkins <andyparkins@gmail.com> writes:
> 
>>  
>> +	/* If there isn't enough data remaining for a whole message or there
>> +	 * is no , give up */
> 
> "there is no , "???
> 

spoon

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
