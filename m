X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Bugreport: core-tutorial example outdated?
Date: Wed, 25 Oct 2006 19:15:17 +0200
Message-ID: <453F9BA5.3020104@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 17:15:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:224ad0fd4f2efe95e6ec4f0a3ca8a73c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30078>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcmLd-0000Ui-C6 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 19:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1160995AbWJYRPT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbWJYRPT
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 13:15:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:18926 "EHLO
 moutng.kundenserver.de") by vger.kernel.org with ESMTP id S965221AbWJYRPS
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 13:15:18 -0400
Received: from [84.154.119.220] (helo=[192.168.1.10]) by
 mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis), id
 0ML25U-1GcmLU1QAs-0008Bz; Wed, 25 Oct 2006 19:15:16 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi there!

I just studied
http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html
to get more into the details of git. But the following commands:

$ git-cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
$ git-cat-file "blob" 557db03

just bring up a

fatal: Not a valid object name 557db03de

I guess the documentation is slightly outdated and might need a fix.

Best greets,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
