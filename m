From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 09:39:52 +0000
Organization: linutronix
Message-ID: <1115890792.22180.306.camel@tglx>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	 <1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	 <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	 <1115884637.22180.277.camel@tglx>
	 <1895.10.10.10.24.1115890333.squirrel@linux1>
Reply-To: tglx@linutronix.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 11:32:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWA2b-0005yK-QA
	for gcvg-git@gmane.org; Thu, 12 May 2005 11:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVELJjH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 05:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVELJjH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 05:39:07 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:42887
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261369AbVELJjE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 05:39:04 -0400
Received: from mail.tec.linutronix.de (unknown [192.168.0.1])
	by mail.tglx.de (Postfix) with ESMTP id F0C0265C003;
	Thu, 12 May 2005 11:38:55 +0200 (CEST)
Received: from tglx.tec.linutronix.de (tglx.tec.linutronix.de [192.168.0.68])
	by mail.tec.linutronix.de (Postfix) with ESMTP id E827728204;
	Thu, 12 May 2005 11:38:58 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <1895.10.10.10.24.1115890333.squirrel@linux1>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-05-12 at 05:32 -0400, Sean wrote:
> In fact, please see attached .png image that shows how the nice gitk tool
> from Paul Mackerras displays it exactly as you request WITHOUT Repo-id.

Please do the complete test. Sync test2 with test1 and show me the
picture there. It will be the same as you see in test1, which is wrong

> * Please * explain what problem you are trying to solve and how repoid
> will solve it.

Having the repository id in there you can identify the different order
of test2

tglx


