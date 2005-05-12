From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 00:56:12 +0000
Organization: linutronix
Message-ID: <1115859372.22180.266.camel@tglx>
References: <1115847510.22180.108.camel@tglx>
	 <2780.10.10.10.24.1115848852.squirrel@linux1>
	 <1115849141.22180.123.camel@tglx>
	 <2807.10.10.10.24.1115850254.squirrel@linux1>
	 <1115850619.22180.133.camel@tglx>
	 <2853.10.10.10.24.1115850996.squirrel@linux1>
	 <1115851718.22180.153.camel@tglx>
	 <2883.10.10.10.24.1115852463.squirrel@linux1>
	 <1115854419.22180.196.camel@tglx>
	 <2997.10.10.10.24.1115855049.squirrel@linux1>
	 <1115857838.22180.250.camel@tglx>
	 <3185.10.10.10.24.1115858739.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 02:48:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW1s0-0000r6-GK
	for gcvg-git@gmane.org; Thu, 12 May 2005 02:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVELAz0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 20:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVELAz0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 20:55:26 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:62851
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261232AbVELAzU
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 20:55:20 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id A6DE965C003;
	Thu, 12 May 2005 02:55:18 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id A6D3128204;
	Thu, 12 May 2005 02:55:20 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <3185.10.10.10.24.1115858739.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-05-11 at 20:45 -0400, Sean wrote:
> Can we please not _invent_ problems where there are none?  Can you show a
> specific case today where repoid would make one ounce of difference in the
> life of anyone?

Try to find out the history of kernel.org/.../dwmw2/audit-2.6 in correct
order, using the available tools. 

Come back to me when you are done.

> No, you seem to want it both ways.  Sometimes it's important to you to
> know where an object came from and how it got there, and sometimes it's
> not.  Interesting blind spot.

He ? 

I was not aware, that omitting irrelevant information is creating a
blind spot. 

Period. End of thread.

tglx


