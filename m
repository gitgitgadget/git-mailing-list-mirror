X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 21:23:15 +0000
Message-ID: <200612142123.16291.andyparkins@gmail.com>
References: <200612141519.44294.andyparkins@gmail.com> <7vejr22ose.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 21:26:06 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pCRF+TuSdzqqQZtisSDDnfG+6YQ2rja+KZzfHXp+O4lYIqJw48wyBmR+rlHQe49mtDInXVYqPPnzmCjnastXy77edFKgBmWCCS3F47f1ybCD8x6YyPe/R/pAnJYDVdHqq/zWwW+du8SF0tJhQDQJud+kGE/FUhmePywOeNfhNKY=
User-Agent: KMail/1.9.5
In-Reply-To: <7vejr22ose.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34403>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guy5b-000220-Jh for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751688AbWLNV0A (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWLNV0A
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:26:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:26566 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751688AbWLNV0A (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 16:26:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so623437uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 13:25:57 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr2169336ugh.1166131557596; Thu, 14
 Dec 2006 13:25:57 -0800 (PST)
Received: from ?192.168.1.48? ( [84.201.153.164]) by mx.google.com with ESMTP
 id e34sm3179661ugd.2006.12.14.13.25.56; Thu, 14 Dec 2006 13:25:56 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, December 14 20:41, Junio C Hamano wrote:

> However, the fmt-merge-message was designed so for a very
> practical reason --- to keep Merge commit log messages Linus
> makes in the kernel repository short and readable.

I'm only after consistency; how about the reverse solution: drop the "into" 
completely?


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
