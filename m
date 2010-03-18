From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's in a name? Let's use a (uuid,name,email) triplet
Date: Thu, 18 Mar 2010 12:47:48 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003181241080.18017@i5.linux-foundation.org>
References: <4ba2293f.c5c2f10a.5e9c.5c4a@mx.google.com>  <alpine.LFD.2.00.1003181022040.18017@i5.linux-foundation.org>  <9e4733911003181202h23b3d702xce8fc0670a994d52@mail.gmail.com>  <alpine.LFD.2.00.1003181203370.18017@i5.linux-foundation.org> 
 <9e4733911003181216m59a09ad6y6c7c890714d0d20b@mail.gmail.com>  <alpine.LFD.2.00.1003181218400.18017@i5.linux-foundation.org> <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:51:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsLkC-0002jZ-G4
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab0CRTup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:50:45 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33260 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752374Ab0CRTuo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Mar 2010 15:50:44 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJofjs017508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Mar 2010 12:50:42 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2IJof8a012190;
	Thu, 18 Mar 2010 12:50:41 -0700
In-Reply-To: <9e4733911003181237i56a00a78k31fac2c1afe5a674@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142508>



On Thu, 18 Mar 2010, Jon Smirl wrote:
> 
> Go ahead and commit that .mailmap I made. It really cleans up the
> statistics by fixing 500 errors is people's names. Just don't point
> the ensuing flame war at me, your hide is tougher.

How hard is it to understand the notion of "people just don't _care_ 
enough"?

Look at CVS. Look at three _decades_ of CVS. Then look at the 
"identifiers" that thing used. 

Git is much better. Git is better for two reasons:

 - We allow/encourage people to use way more meaningful identifiers

 - Exactly _because_ what we use is meaningful to people, most people 
   bother to try.

And you don't seem to understand that whole "meaningful" part. If you 
don't have the social understanding of how people actually _work_, then 
nothing I say can explain it.

Let me try one more time: do the statistics on "committer information" vs 
"author information" on the Linux kernel repository, and count the types 
of errors that happen. I can explain the errors and why they happen, and 
it has everything to do with how _humans_work_ (*).

If you don't understand that, then there's no point in arguing.

			Linus

(*) I'll give you one answer in the next email. But before you read that 
email, try to think about it, and see if you can guess at patterns.
