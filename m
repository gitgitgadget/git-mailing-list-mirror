X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: master and origin
Date: Sun, 29 Oct 2006 21:53:57 +0100
Message-ID: <4d8e3fd30610291253s2d8000dfx942e0fa20e0057f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:54:32 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=db2BRwOj50/s9Je+Cvjv/KfsGACuqTeYdo/OMLc6UYfby9NAnbJUp3Y5NRGDx1+5SzGGVh0aXA4WEJLBUt9HrTcPZO5oNBvTWUF2jGXHd4L1F8c7oW006TW9yrfeoKMWaz8mg6JPyPVmFhh4N5GYKfdOpTl0qea0fPUkDHe95mQ=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30459>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHfV-0002fi-Q8 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030220AbWJ2UyA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWJ2Ux7
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:53:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:29167 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1030220AbWJ2Ux7
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:53:59 -0500
Received: by nf-out-0910.google.com with SMTP id c2so1982254nfe for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:53:57 -0800 (PST)
Received: by 10.78.97.7 with SMTP id u7mr3620417hub; Sun, 29 Oct 2006
 12:53:57 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Sun, 29 Oct 2006 12:53:56 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi all,
I went trough the docs I found on the web but I still don't fully
understand why if I clone a remote repository my local copy has two
branches, origin (that is always a exact copy of the remote
repository) and master which is... what? The branch supposed to be
used for local development?

I'm used to just checkout to a new branch, do my own development and
then diff against origin so I'm missing why I see the master branch.

I'm sure I'm missing something very fundamental but I cannot figure
out what is it :-)

Thanks!

regards,
-- 
Paolo
