X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Advice on converting to git from versioning-by-directory
Date: Thu, 23 Nov 2006 10:09:39 +0000
Message-ID: <200611231009.40637.andyparkins@gmail.com>
References: <200611230916.46415.andyparkins@gmail.com> <456570BE.5040702@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 10:09:53 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VjsEc3TOyC9518qmlIAbC8yG+GXU0WQWPXImfekgV+8LRDDnTvBvLvKIgObY5ZQ4qQwpgBNydkSuT3IY2rxxr4+bVVm8cAl8/QuRsFwnhq3Y0b2d83Yk79ltdFadEaCTz/ysCiRG5a31bgNCvEayasE9VENLRKEqG6Nb5ecAs8o=
User-Agent: KMail/1.9.5
In-Reply-To: <456570BE.5040702@shadowen.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32133>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnBWg-00040C-G8 for gcvg-git@gmane.org; Thu, 23 Nov
 2006 11:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757322AbWKWKJq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 05:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757325AbWKWKJp
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 05:09:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:53024 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1757322AbWKWKJp
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 05:09:45 -0500
Received: by ug-out-1314.google.com with SMTP id 44so396126uga for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 02:09:43 -0800 (PST)
Received: by 10.67.119.9 with SMTP id w9mr4939438ugm.1164276583766; Thu, 23
 Nov 2006 02:09:43 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id y1sm2337795uge.2006.11.23.02.09.43; Thu, 23 Nov 2006 02:09:43 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 November 23 09:58, Andy Whitcroft wrote:

> Ok, why is this so different from any normal SVN repository?
> Yes your branches are in the 'wrong' place.  But they behave as you'd
> expect don't they?  Each one has linear history from its appearance,

What an absolutely excellent idea.  It's so obvious now you say it, but all 
the best ideas are.

> No idea if thats any use...

It's of enormous use.  Thank you very much.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
