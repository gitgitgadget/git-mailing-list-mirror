From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 12:20:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org>
 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:23:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLJL-0005Qn-Ah
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0CRTXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:23:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58030 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751924Ab0CRTXG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:23:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJN26m015540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 12:23:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJN29B011003;
	Thu, 18 Mar 2010 12:23:02 -0700
In-Reply-To: <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142498>



On Thu, 18 Mar 2010, Jon Smirl wrote:
> 
> I happen to think that the concept of privacy and working on an open
> source project are fairly incompatible. But apparently their are
> people who think otherwise.  The use would be to reconstruct that
> mailmap I made, but with the email addresses replaced with SHA1 hashes
> of the email. No human would use the SHA1s, they're just there to
> obscure the emails.

I really see that as a bad thing, not a good thing. It's like enabling 
some crazy shit and making it official.

If you don't want to reveal your real name, use a fake address. Just don't 
expect anybody to want to work with you. 

The LAST thing we want is built-in git support for doing f*cking stupid 
things.  You can do stupid things with it on your own without us helping 
and encouraging you.

		Linus
