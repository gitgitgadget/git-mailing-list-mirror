From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 17:17:04 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181715490.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <46a038f91003181536ib3b74f8o40603a4cee13d62b@mail.gmail.com>  <alpine.LFD.2.00.1003181909180.31128@xanadu.home> 
 <9e4733911003181626t7d143903mbc5737ff2fa5100f@mail.gmail.com>  <alpine.LFD.2.00.1003181930230.31128@xanadu.home>  <9e4733911003181641n400704c9r1a0addd6fce6fce0@mail.gmail.com>  <alpine.LFD.2.00.1003181953010.31128@xanadu.home>
 <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 01:20:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsPwi-0006ig-H5
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 01:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab0CSAUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 20:20:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51918 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753050Ab0CSAUD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 20:20:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2J0Jx0p005400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 17:20:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2J0JxX4024069;
	Thu, 18 Mar 2010 17:19:59 -0700
In-Reply-To: <9e4733911003181716q7f141d5eqd18218c749ca4624@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142545>



On Thu, 18 Mar 2010, Jon Smirl wrote:
> 
> I'll sent you the file and you can commit it. Please take full credit for it.

Umm. You do realize that what people complained about was mostly that they 
felt a lot of the entries were totally pointless.

For example, you included names whether they were mistyped or not, and 
claimed that everybody needed to always be in the mailmap if they ever 
made any commit.

So I think 99% of the flames were due to just the patch being stupid.

		Linus
