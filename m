X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Possible but in gitweb
Date: Sat, 18 Nov 2006 19:01:30 +0100
Message-ID: <200611181901.31708.jnareb@gmail.com>
References: <4d8e3fd30611180858xf28e958g8511f2eb68d53848@mail.gmail.com> <ejng62$k2m$1@sea.gmane.org> <4d8e3fd30611180942p548a92d1ufc9e0dcfabedb59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 18:00:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sZDLZ45NBX7Y9VyhJy8rkjpBsd6pCkm3P1b0e/OFhTGymw74VSooh+lCWv+KG+ERgGtJu4j6us9ZWMi4GHI1ttKUSjT6Uks6xozz+M0lyRxrUy8KNE8qEh6TBbuFzmec4K0WjXPjUh1xL+TZ5bCX6OR4EkrZ0SyXFwTbKOiJN8Q=
User-Agent: KMail/1.9.3
In-Reply-To: <4d8e3fd30611180942p548a92d1ufc9e0dcfabedb59@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31782>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlUUO-0007VC-BE for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:00:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755296AbWKRSAT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755897AbWKRSAT
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:00:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:9845 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755296AbWKRSAR
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:00:17 -0500
Received: by ug-out-1314.google.com with SMTP id m3so932119ugc for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 10:00:15 -0800 (PST)
Received: by 10.67.121.15 with SMTP id y15mr3246131ugm.1163872815490; Sat, 18
 Nov 2006 10:00:15 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id i39sm1799017ugd.2006.11.18.10.00.15; Sat, 18 Nov
 2006 10:00:15 -0800 (PST)
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

Paolo Ciarrocchi wrote:
> On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Paolo Ciarrocchi wrote:
>>>
>>> Browsing the repo I reach the following URL
>>> http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=blob;f=LinuxKernelDevelopmentProcess.html;hb=HEAD
>>> that is not accessible.
>>
>> Because HEAD is master, not html, and there us no such file in master branch?
> 
> Fair enough but then there should be no link in the web interface.
> That sounds like a bug in the interface.

Where did you find this link? On what page?

"Browsing the repo" is not enough information to discover where
there is a bug.
-- 
Jakub Narebski
