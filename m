X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: (unknown)
Date: Wed, 25 Oct 2006 23:03:07 +0100
Message-ID: <200610252303.07900.andyparkins@gmail.com>
References: <E1Gck2K-0003H4-00@dvr.360vision.com> <200610251610.02446.andyparkins@gmail.com> <7vods0b5rk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 22:05:57 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j2OtDCHrJ9Nfs4nZOqAntxcINngCnKXCHUzhMLhlOdPtYiA1rf3vxdoRSzY1YC/nkZ1Bxb5iEaSgow4/YD0/fzFR0mro2iT91Y+FTYEo7O7YbC3TM0VulN+a1l8NcEOw3ULfTmFZZj7+1U3PJdweqGaIuyMaQf7OH03mkoUj35U=
User-Agent: KMail/1.9.5
In-Reply-To: <7vods0b5rk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30106>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcqsW-0002uP-W0 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751705AbWJYWFi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWJYWFi
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:05:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:9572 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1751705AbWJYWFh
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:05:37 -0400
Received: by ug-out-1314.google.com with SMTP id 32so234906ugm for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 15:05:36 -0700 (PDT)
Received: by 10.67.24.13 with SMTP id b13mr1672313ugj; Wed, 25 Oct 2006
 15:05:36 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 30sm2827031ugf.2006.10.25.15.05.35; Wed, 25 Oct
 2006 15:05:35 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, October 25 19:38, Junio C Hamano wrote:

> > I did try that, but then the branches don't appear in git branch.  I
> > still like that they exist.
>
> "git branch -r" perhaps.

That's pretty good.  It makes things like

  git-log remotes/origin/master..master

A bit long winded, but it's certainly what I asked for.

You guys really have thought of everything.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
