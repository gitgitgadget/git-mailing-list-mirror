X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Adapt to fuse in kernel 2.6.17
Date: Sun, 12 Nov 2006 21:01:28 +0100
Organization: Dewire
Message-ID: <200611122101.28910.robin.rosenberg.lists@dewire.com>
References: <20061112184519.8713.7707.stgit@lathund.dewire.com> <200611121956.25481.robin.rosenberg.lists@dewire.com> <455776A7.6050707@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 12 Nov 2006 20:00:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <455776A7.6050707@garzik.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31274>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjLUr-0001dE-7z for gcvg-git@gmane.org; Sun, 12 Nov
 2006 21:00:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753013AbWKLT7y convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006 14:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbWKLT7y
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 14:59:54 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10540 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1753003AbWKLT7y convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006
 14:59:54 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 85CA5802806; Sun, 12 Nov 2006 20:56:24 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 07086-06; Sun, 12 Nov
 2006 20:56:24 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 44A9E800784; Sun, 12 Nov 2006 20:56:22 +0100 (CET)
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

s=C3=B6ndag 12 november 2006 20:31 skrev Jeff Garzik:
> Robin Rosenberg wrote:
> > This was a patch to GITFS, which may be somewhat unclear from the S=
ubject
> > line :)
>
> I blinked, and I missed it.  Where can I find gitfs?  I've long thoug=
ht
> about doing something like that myself.

It's listed on the wiki and located at=20
http://www.sfgoth.com/~mitch/linux/gitfs/

