X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: How-to revert a locally modified file
Date: Thu, 30 Nov 2006 21:23:47 -0800
Message-ID: <456FBC63.5090609@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 05:24:12 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32850>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq0sW-0007Vx-Nd for gcvg-git@gmane.org; Fri, 01 Dec
 2006 06:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759081AbWLAFXo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 00:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759078AbWLAFXo
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 00:23:44 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:39351 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S1759077AbWLAFXn (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 00:23:43 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id 9E30157A6F for <git@vger.kernel.org>; Thu, 30 Nov
 2006 21:19:46 -0800 (PST)
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hello,

I searched the net and couldn't find the answer to how to revert a
file to its "pre-modified" state.

I did see in the 0.99.7 To Do:

* Perhaps a tool to revert a single file to pre-modification
state? git-cat-file blob `git-ls-files | grep foo` >foo or
git-cat-file blob `git-ls-tree HEAD foo` >foo? What should
the command be called? git-revert is taken so is
git-checkout.

Did such a command come to be?

Thanks,

