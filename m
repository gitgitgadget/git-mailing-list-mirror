X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Adapt to fuse in kernel 2.6.17
Date: Sun, 12 Nov 2006 19:56:25 +0100
Organization: Dewire
Message-ID: <200611121956.25481.robin.rosenberg.lists@dewire.com>
References: <20061112184519.8713.7707.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 12 Nov 2006 18:55:13 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061112184519.8713.7707.stgit@lathund.dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31270>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjKTs-00052W-Tq for gcvg-git@gmane.org; Sun, 12 Nov
 2006 19:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752745AbWKLSyz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 13:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752762AbWKLSyz
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 13:54:55 -0500
Received: from [83.140.172.130] ([83.140.172.130]:57386 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1752745AbWKLSyz (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 13:54:55 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id D193B80280C for <git@vger.kernel.org>; Sun, 12 Nov
 2006 19:51:18 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 06519-09 for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 19:51:18 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 94B91802803 for <git@vger.kernel.org>; Sun, 12 Nov 2006
 19:51:18 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


This was a patch to GITFS, which may be somewhat unclear from the Subject 
line :)

