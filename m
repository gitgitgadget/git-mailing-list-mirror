X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 22:41:49 +0100
Organization: Dewire
Message-ID: <200611132241.49458.robin.rosenberg.lists@dewire.com>
References: <45530CEE.6030008@b-i-t.de> <200611131930.18300.robin.rosenberg.lists@dewire.com> <200611131957.48801.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 21:41:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <200611131957.48801.jnareb@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31322>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjjY7-0000sB-Jg for gcvg-git@gmane.org; Mon, 13 Nov
 2006 22:41:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933078AbWKMVk3 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 16:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933080AbWKMVk3
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 16:40:29 -0500
Received: from [83.140.172.130] ([83.140.172.130]:59989 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S933078AbWKMVkM convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006
 16:40:12 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 11E45802654; Mon, 13 Nov 2006 22:36:42 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 23707-02; Mon, 13 Nov
 2006 22:36:41 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id BFF4F800784; Mon, 13 Nov 2006 22:36:39 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

m=C3=A5ndag 13 november 2006 19:57 skrev Jakub Narebski:
> That was my idea, to have i18n.filesystemEncoding configuration varia=
ble
> to convert between filesystem encoding (which is usually something yo=
u
> don't have control over, and which depends from place to place, but n=
ot
> from repository to repository) and UTF-8 encoding git would store
> filenames.

Yes, I know.

