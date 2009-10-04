Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 9637 invoked by uid 107); 4 Oct 2009 09:32:34 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 05:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbZJDJ2J (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 05:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753037AbZJDJ2J
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 05:28:09 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47037 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752257AbZJDJ2I convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 4 Oct 2009 05:28:08 -0400
MIME-version: 1.0
Content-type: Text/Plain; charset=utf-8
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KQZ00JJCGXUKW70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 04 Oct 2009 11:27:30 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KQZ0068JGXTXX20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 04 Oct 2009 11:27:30 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.4.91535
From:	Johan Herland <johan@herland.net>
To:	Octavian =?utf-8?q?R=C3=A2=C5=9Fni=C5=A3=C4=83?= 
	<orasnita@gmail.com>
Subject: Re: previous references
Date:	Sun, 04 Oct 2009 11:27:29 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
Cc:	git@vger.kernel.org
References: <8E72DAAF9F8E4024BB819F3F83CCFC79@teddy>
In-reply-to: <8E72DAAF9F8E4024BB819F3F83CCFC79@teddy>
Content-transfer-encoding: 8BIT
Message-id: <200910041127.29588.johan@herland.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sunday 04 October 2009, Octavian Râşniţă wrote:
> Are the following commands specifying the same reference?
> 
> prompt> git log -1 HEAD^^^ ... log entry ...
> prompt> git log -1 HEAD^~2 ... log entry ...
> prompt> git log -1 HEAD~1^^ ... log entry ...
> prompt> git log -1 HEAD~3 ... log entry ...

Yes

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
