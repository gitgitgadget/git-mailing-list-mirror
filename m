X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 22 Nov 2006 23:52:57 -0300
Message-ID: <200611230252.kAN2qviC006596@laptop13.inf.utfsm.cl>
References: <hanwen@xs4all.nl>
NNTP-Posting-Date: Thu, 23 Nov 2006 13:01:17 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from Han-Wen Nienhuys <hanwen@xs4all.nl> 
   of "Fri, 17 Nov 2006 01:05:17 BST." <455CFCBD.8040901@xs4all.nl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 23 Nov 2006 10:00:16 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32138>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnECM-0007tA-Pr for gcvg-git@gmane.org; Thu, 23 Nov
 2006 14:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756313AbWKWNAt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 08:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757365AbWKWNAt
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 08:00:49 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52199 "EHLO
 inti.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1756313AbWKWNAs (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 08:00:48 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
 by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id kAND0F90014484
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); Thu, 23
 Nov 2006 10:00:15 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kAN2qviC006596; Wed, 22
 Nov 2006 23:52:57 -0300
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:

[...]

> Until that time, it would be good goal to remove all idiosyncrasies,
> all gratuitious asymetries and needless limitations in the commands of
> git, eg.
> 
>  - clone but not a put-clone,

Lost me there.

>  - pull = merge + fetch, but no command for merge + throw

throw + merge (at the remote end, that is)?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
