From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 13:41:30 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011340130.3277@nehalem.linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
 <20080801131127.20b3acfd.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 22:42:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP1SM-00074F-KV
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 22:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbYHAUld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 16:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757212AbYHAUld
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 16:41:33 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40539 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756949AbYHAUlc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 16:41:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71KfVl6001890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 13:41:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71KfUSa001991;
	Fri, 1 Aug 2008 13:41:30 -0700
In-Reply-To: <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.412 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91097>



On Fri, 1 Aug 2008, Linus Torvalds wrote:
> 
> If you want to turn it into emails, you need to follow the email rules. 
> You're cutting-and-pasting anyway, it's not like this is fundamentally 
> hard.

Btw, if sending emails was the _only_ thing that Author line was used for, 
or even the main thing, then it would make sense to keep it in some email 
format. But it really isn't. Sending emails to people is the _least_ 
common thing you do with it. Most of the time you just want to see the 
name in a nice readable format.

		Linus
