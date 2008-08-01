From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 12:45:50 -0700
Message-ID: <20080801124550.26b9efc0.akpm@linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP0aT-0002t9-Nj
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 21:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYHATpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 15:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbYHATpw
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 15:45:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49681 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750759AbYHATpw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 15:45:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71JjoDa029355
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 1 Aug 2008 12:45:51 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71Jjoi6032128;
	Fri, 1 Aug 2008 12:45:50 -0700
In-Reply-To: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91080>

On Fri, 1 Aug 2008 12:34:58 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> And Andrew, this is true of Signed-off-by: lines too, btw. If you actually 
> want to send emails to them, _then_ you need to add quotes to follow the 
> email rules. 

That's how I noticed it - copied, pasted, MTA barfed.

Converting a usable name+email-address into an unusable one seems ... unuseful.
