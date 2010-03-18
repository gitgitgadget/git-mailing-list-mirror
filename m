From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 12:40:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181237450.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com> <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
 <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:43:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLcd-0007WX-3V
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab0CRTnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:43:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33951 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143Ab0CRTnC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:43:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJh0It016944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 12:43:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJgxrA011929;
	Thu, 18 Mar 2010 12:43:00 -0700
In-Reply-To: <b4087cc51003181232q6b8ec056lad79c62926b65a10@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142506>



On Thu, 18 Mar 2010, Michael Witten wrote:
> 
> What a uuid provides is that very property of long-term attachment; a
> git user can change the name/email pair but keep the same uuid.

I don't think you understand what "attachment" means.

Think about your wife, your kids, or your pet. THAT is attachment.

Random 16-letter letter-jumble? No. People will _never_ care. They'll 
simply not care. 

It's true that people _already_ don't care too much about their emails, 
and that typos and simply job changes (or annoying ISP's) will change 
them. But that would be orders of magnitude _worse_ with something like a 
uuid.

> It IS a name/email pair (if you want or if that is enforced); it's
> just one that isn't as volatile.

Don't be an idiot.

Try to think like a HUMAN. Not a computer scientist. And ponder.

It's a _social_ issue, not a "let's tattoo this uuid on everybody".

		Linus
