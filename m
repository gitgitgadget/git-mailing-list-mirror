X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: GIT plugin for Jira (issue tracker)
Date: Fri, 1 Dec 2006 15:28:30 -0600
Message-ID: <89b129c60612011328p49d45da8m640fc8b4bcceef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 21:28:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q1V7gxgQP5EbfTJcSsJydZi6tyU+z6tw0ihxaByBr2fBibaLXwnTK6GH2hpKU7eBg4F/qJKZ9NmbSwEZ+jQ2iiU59lBQh8tGR2kJEMCL67vrtylSH/nMMI8No6LGreNnArDf2rl9+W8g6tDBkWrw/MX+c+R8WJv8neGBby/jF+o=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32967>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqFvw-0003Hy-Ld for gcvg-git@gmane.org; Fri, 01 Dec
 2006 22:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161825AbWLAV2d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 16:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161829AbWLAV2d
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 16:28:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:18892 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161825AbWLAV2c
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 16:28:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2538698uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 13:28:31 -0800 (PST)
Received: by 10.78.164.13 with SMTP id m13mr5279132hue.1165008510675; Fri, 01
 Dec 2006 13:28:30 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Fri, 1 Dec 2006 13:28:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I was curious if anyone has created a GIT plugin for the Jira issue
tracker?  I have come across a mercurial plugin.  I have an idea that
I could nightly track our GIT repository with mercurial then I could
use the mercurial plugin with Jira.  But I wanted to check first on
the existence of a GIT plugin for Jira.[1]

Thanks,

Sean

[1]  http://www.atlassian.com/software/jira/

-- 
