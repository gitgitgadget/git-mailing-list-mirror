From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 08:32:45 -0400 (EDT)
Message-ID: <1838.10.10.10.24.1115901165.squirrel@linux1>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com> 
    <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com> 
    <1115858022.22180.256.camel@tglx>
    <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> 
    <1115884637.22180.277.camel@tglx> 
    <1895.10.10.10.24.1115890333.squirrel@linux1> 
    <1115890792.22180.306.camel@tglx> 
    <3656.10.10.10.24.1115891188.squirrel@linux1> 
    <1115896713.22180.314.camel@tglx> 
    <3745.10.10.10.24.1115897090.squirrel@linux1> 
    <1115898230.11872.8.camel@tglx> 
    <2247.10.10.10.24.1115898521.squirrel@linux1>
    <1115900963.16187.575.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: tglx@linutronix.de, "Junio C Hamano" <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 14:25:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWCkU-00060l-EH
	for gcvg-git@gmane.org; Thu, 12 May 2005 14:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261729AbVELMcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 08:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVELMcs
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 08:32:48 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:50914 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261729AbVELMcq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 08:32:46 -0400
Received: from linux1 ([69.156.111.46]) by simmts5-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050512123245.VWJV11606.simmts5-srv.bellnexxia.net@linux1>;
          Thu, 12 May 2005 08:32:45 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4CCWjej012551;
	Thu, 12 May 2005 08:32:45 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 12 May 2005 08:32:45 -0400 (EDT)
In-Reply-To: <1115900963.16187.575.camel@hades.cambridge.redhat.com>
To: "David Woodhouse" <dwmw2@infradead.org>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 8:29 am, David Woodhouse said:
> On Thu, 2005-05-12 at 07:48 -0400, Sean wrote:
>> What is this correct order you're talking about?   The order is _given_
>> explicitly in the parent child relationships.  There is no other order
>> of
>> any value, at least none you've been able to put forth.
>
> Now you're just being silly. You _replied_ to a message in which it was
> stated perfectly coherently. Even you appeared to understand the
> explanation at that point.
>

David,

I gave you a solution to your problem, what is the issue that remains?

Sean


