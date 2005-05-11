From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 19:44:09 -0400 (EDT)
Message-ID: <2997.10.10.10.24.1115855049.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> 
    <2780.10.10.10.24.1115848852.squirrel@linux1> 
    <1115849141.22180.123.camel@tglx> 
    <2807.10.10.10.24.1115850254.squirrel@linux1> 
    <1115850619.22180.133.camel@tglx> 
    <2853.10.10.10.24.1115850996.squirrel@linux1> 
    <1115851718.22180.153.camel@tglx> 
    <2883.10.10.10.24.1115852463.squirrel@linux1>
    <1115854419.22180.196.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 01:36:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW0ks-0002Dx-Hc
	for gcvg-git@gmane.org; Thu, 12 May 2005 01:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbVEKXoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 19:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVEKXoP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 19:44:15 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:55745 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261323AbVEKXoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 19:44:10 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050511234409.PTTZ26867.simmts8-srv.bellnexxia.net@linux1>;
          Wed, 11 May 2005 19:44:09 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4BNi9ae004431;
	Wed, 11 May 2005 19:44:09 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Wed, 11 May 2005 19:44:09 -0400 (EDT)
In-Reply-To: <1115854419.22180.196.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 11, 2005 7:33 pm, Thomas Gleixner said:

> He? What the hell have the sparc-2.6 and net-2.6 in common except the
> same owner/maintainer ? Should we base the heuristics on directories and
> filenames ? Cool.

What problem are you trying to solve?  Has dave or russell or anybody with
multiple repositories given you reason to think they have a problem
tracking their personal repositories?   I doubt it very much.

>> The only point would be to show chain of command, but you don't seem
>> interested in that.
>
> What is the chain of commands good for ? Does the chain of commands
> change the history information in a specific repository ?

The chain of command might be good to know in the same way that an
accurate signed-off-by chain is good to know.

> No.

Yes.  Not that I care personally very much.

> If you buy food, then it is relevant if you get it from A directly or
> via B. The commit and the referenced tree is immutable and does neither
> change the consistency nor gets uneatable.

Lol..

> True, but not with a plain rsync approach

Agreed.

Sean.


