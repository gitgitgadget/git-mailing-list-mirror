X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Ed <ed.since.06@gmail.com>
Subject: Unprivileged User
Date: Thu, 30 Nov 2006 00:54:54 -0500
Message-ID: <2b9545a0611292154r4334d1afn1f49bbd3be2c3374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 05:55:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XFsLsmeVhgEEIzn0ZW6oAzrt6YP6HyBYBkuQiJTvMTnFI7GQpwkBotNdNqWc68RDGfmU2TNOTF5i46lXVDlsfiZmQsDpLMXsLF6ul2vxApws9KtCSnzDPqlpivbFz/yZnLYojccNLprzpwOFkV7QNejIuWdpjWSDnI6r1I1PuxY=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32704>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpesx-0001mq-R1 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 06:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754665AbWK3Fy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 00:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbWK3Fy5
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 00:54:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:55106 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754665AbWK3Fy4
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 00:54:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2016980uga for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 21:54:54 -0800 (PST)
Received: by 10.78.57.11 with SMTP id f11mr3134031hua.1164866094555; Wed, 29
 Nov 2006 21:54:54 -0800 (PST)
Received: by 10.78.206.11 with HTTP; Wed, 29 Nov 2006 21:54:54 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi, I'm new to git.  Just got everything setup and imported a new project.

From gitweb it says that my git project's owner is: Unprivileged User

Should I be worried about this when I begin using this git project with others?

How would I resolve this, to make the owner as the name I set in my
~/.gitconfig, or is there something I didn't read in the docs?

Thanks, beside this small glitch, git has been great.

