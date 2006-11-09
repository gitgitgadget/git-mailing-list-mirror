X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Umesh Deshpande <umesh.deshpande@calsoftinc.com>
Subject: Command for reverting all patches below particular commit
Date: Thu, 09 Nov 2006 15:39:07 +0530
Message-ID: <4552FE43.7020804@calsoftinc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 10:08:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
X-imss-version: 2.044
X-imss-result: Passed
X-imss-approveListMatch: *@calsoftinc.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31191>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6pC-00009P-EV for gcvg-git@gmane.org; Thu, 09 Nov
 2006 11:07:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753998AbWKIKHr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 05:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754781AbWKIKHq
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 05:07:46 -0500
Received: from [203.199.144.195] ([203.199.144.195]:2189 "EHLO
 mail.calsofthq.com") by vger.kernel.org with ESMTP id S1753998AbWKIKHp (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 05:07:45 -0500
Received: from imss.calsofthq.com (imss.calsofthq.com [172.16.0.44]) by
 mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id kA9A7dEE024783 for
 <git@vger.kernel.org>; Thu, 9 Nov 2006 15:37:43 +0530
Received: from imss.calsofthq.com (localhost.localdomain [127.0.0.1]) by
 localhost.calsofthq.com (Postfix) with ESMTP id D4125179C9F for
 <git@vger.kernel.org>; Thu,  9 Nov 2006 15:37:39 +0530 (IST)
Received: from mail.calsofthq.com (mail.calsofthq.com [172.16.0.7])by 
 imss.calsofthq.com (Postfix) with ESMTP id BE58E179C9Efor 
 <git@vger.kernel.org>; Thu,  9 Nov 2006 15:37:39 +0530 (IST)
Received: from [172.16.3.248] ([172.16.3.248])(authenticated bits=0)by 
 mail.calsofthq.com (8.13.6/8.13.6) with ESMTP id 
 kA9A7YY5024765(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 
 verify=NO)for <git@vger.kernel.org>; Thu, 9 Nov 2006 15:37:39 +0530
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,
I want to revert a particular commit, but because of dependency issues I 
am not able to do so. The revert operation fails.
I want to revert all the commits below the specified commit so that I 
will be able to remove that particular commit.
Is there any command to do this?

Thanks

Regards
