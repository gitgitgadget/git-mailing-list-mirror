X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: reexporting git repository via git-daemon
Date: Sun, 10 Dec 2006 18:22:08 +0100
Organization: Dewire
Message-ID: <200612101822.09385.robin.rosenberg.lists@dewire.com>
References: <200612082212.09682.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 17:19:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <200612082212.09682.arekm@maven.pl>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33902>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSL3-0003pL-I1 for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762269AbWLJRTm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 12:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762273AbWLJRTl
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:19:41 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11058 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1762269AbWLJRTl (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 12:19:41 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 1E2578030B8; Sun, 10 Dec 2006 18:15:44 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 08829-01; Sun, 10 Dec
 2006 18:15:43 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id C511380281C; Sun, 10 Dec 2006 18:15:41 +0100 (CET)
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Sender: git-owner@vger.kernel.org

fredag 08 december 2006 22:12 skrev Arkadiusz Miskiewicz:
> Hi,
>
> I have weird problem wit git (1.4.4.2).
>
>  git --bare clone git://git.kernel.org/pub/scm/git/git.git
> fetches everything correctly;

You proably ment git clone --bare git://git.kernel.org/pub/scm/git/git.git

Maybe git shouldn't accept useless (in this case) options.

