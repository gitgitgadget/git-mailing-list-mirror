X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 12:35:08 +0000
Message-ID: <200612121235.09984.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:35:25 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cA4dmLXteV57VJjhuMBRZ1RXrHOlEVsL7G7GRPoLUk/udi6Ah88JhZyuezmbfoVwjlVbb++YLRgvjC71GlqkoFj6JegvVmRHEMEp43KuB07Roa3SNdaXnDMJFVAYne/JmWUhud6iY4bLfCWwH2agldxQCrQEYEt82QmRD+jITV8=
User-Agent: KMail/1.9.5
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34092>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu6qu-000130-TR for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751257AbWLLMfR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbWLLMfR
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:35:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:6752 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751257AbWLLMfP (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 07:35:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1649098uga for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 04:35:14 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr11619024ugm.1165926914136; Tue, 12
 Dec 2006 04:35:14 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id b35sm8671455ugd.2006.12.12.04.35.13; Tue, 12 Dec 2006 04:35:13 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

For interests sake I'd like to track the kernel.org linux repository.  
However, I'm not that bothered about tracking the history - it's more that I 
like to have the latest kernel release lying around.

Is there a way that I could just pull individual commits from a git 
repository?  In particular - could I make a repository (obviously not a 
clone, because it wouldn't have all the history) that contained only the 
tagged commits from an upstream repository?

Is it even sensible to want that?  It strikes me that it's possible that there 
isn't that much space/bandwidth saving to be made.  Should I just clone the 
repository and shut up?  :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
