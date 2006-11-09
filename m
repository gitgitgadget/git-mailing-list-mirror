X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: shallow clone failed git pull
Date: Thu, 09 Nov 2006 09:32:45 +0530
Message-ID: <4552A865.5000201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 9 Nov 2006 04:03:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=RaMaGpKkC/IW26MR2F9IOFXnCh0j4pmf0WO7DbK3oJV8gR98VYTrj4nSnPFPZ2HGHd1gC7jhERJYm7pEibs1BDOo3rEcqPrZz33B1aKBjg7a6A6oraN9jteJYaXWChtPi8xIp0eetU2U1KHvJtYgqdwywFtdqIdbDfYz59zBJtA=
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31179>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi18A-0006Un-Mq for gcvg-git@gmane.org; Thu, 09 Nov
 2006 05:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423816AbWKIEDH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 23:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWKIEDG
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 23:03:06 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:3519 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932426AbWKIEDF
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 23:03:05 -0500
Received: by ug-out-1314.google.com with SMTP id m3so109972ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 20:03:04 -0800 (PST)
Received: by 10.78.138.6 with SMTP id l6mr487905hud.1163044984244; Wed, 08
 Nov 2006 20:03:04 -0800 (PST)
Received: from ?217.28.215.183? ( [156.153.255.234]) by mx.google.com with
 ESMTP id 33sm403418hue.2006.11.08.20.03.02; Wed, 08 Nov 2006 20:03:04 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I was using the pu branch i tried to update the git repository and i got this error.

alk 9e950efa20dc8037c27509666cba6999da9368e8
walk 3b6a792f6ace33584897d1af08630c9acc0ce221
* refs/heads/origin: fast forward to branch 'master' of http://repo.or.cz/r/linux-2.6
  old..new: 3d42488..088406b
Auto-following refs/tags/v2.6.19-rc5
shallow clone with http not supported


This repository was not cloned with -depth. I only updated the git tools using the pu branch

