X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 22:55:32 +0000
Message-ID: <200612142255.33564.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7vmz5q18cn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 22:58:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HHBCxFhlWlDbcE41GfZZbQq4vsm9PgAi1+JC+3+e5tCWtUy09fxwCn6uTuvP7tKUJl8xgZ+LEoUyP+wcjDAnz8CyFa7p4z3cWKV668uihRwZo8AQuDaFcI6CTObvPGiMkud0Z79TTCO1/w2Hk4YNvI5n5RZjRHMVaK0ZQRPVOl4=
User-Agent: KMail/1.9.5
In-Reply-To: <7vmz5q18cn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34424>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzWw-0006Am-9C for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751176AbWLNW6U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbWLNW6U
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:58:20 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:26380 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751655AbWLNW6T (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 17:58:19 -0500
Received: by ug-out-1314.google.com with SMTP id 44so646925uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 14:58:18 -0800 (PST)
Received: by 10.66.244.11 with SMTP id r11mr105385ugh.1166137098310; Thu, 14
 Dec 2006 14:58:18 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id g30sm3284623ugd.2006.12.14.14.58.13; Thu, 14 Dec
 2006 14:58:13 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006, December 14 21:22, Junio C Hamano wrote:

> This is interesting.  You said "commit -b", were pointed out
> that you were talking about "checkout -b", and just after saying
> "yup, that is right, I was", you again say "commit -b".

There truly is something wrong with me.  Is there some sort of record for 
number of mistakes made in one thread?  Have I won yet?

I'm not sure about your "commit -b"; is it wise to have /another/ way of 
making a branch?  I mean - I'm clearly confused enough, have a heart :-)


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
