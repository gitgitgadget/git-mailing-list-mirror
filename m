From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 05:46:28 -0400 (EDT)
Message-ID: <3656.10.10.10.24.1115891188.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx> 
    <1895.10.10.10.24.1115890333.squirrel@linux1>
    <1115890792.22180.306.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 11:39:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWAAB-0000oV-Oh
	for gcvg-git@gmane.org; Thu, 12 May 2005 11:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVELJqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 05:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVELJqs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 05:46:48 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:54932 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261379AbVELJqb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 05:46:31 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512094628.QZZX23474.simmts7-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 05:46:28 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4C9kSlr010305;
	Thu, 12 May 2005 05:46:28 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 05:46:28 -0400 (EDT)
In-Reply-To: <1115890792.22180.306.camel@tglx>
To: tglx@linutronix.de
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 5:39 am, Thomas Gleixner said:

> Please do the complete test. Sync test2 with test1 and show me the
> picture there. It will be the same as you see in test1, which is wrong

It will get the fast forward head from test1, and so it _should_ show the
exact same thing!  The repositories are in sync, they should display the
exact same way.  What is the problem?

> Having the repository id in there you can identify the different order
> of test2
>

What different order?   Everything I want as a developer or even as a QA
department is right there in front of me.    What VALUE does some other
order have?   What question will you answer with a different order?   Who
will ask this question?  Why would anyone care?

Sean

