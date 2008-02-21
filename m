From: Onno Kortmann <onno@gmx.net>
Subject: Re: [StGit PATCH] Allow renaming of the top-most branch by just calling stg rename <new-patch-name>
Date: Thu, 21 Feb 2008 22:30:56 +0100
Message-ID: <200802212230.56646.onno@gmx.net>
References: <200802172203.55533.onno@gmx.net> <20080218140005.GA18668@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 22:31:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJ0y-0004La-0j
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 22:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbYBUVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 16:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYBUVbA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 16:31:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:43431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751056AbYBUVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 16:30:59 -0500
Received: (qmail invoked by alias); 21 Feb 2008 21:30:57 -0000
Received: from 14-235-dsl.kielnet.net (EHLO noodle.okhome) [89.27.235.14]
  by mail.gmx.net (mp006) with SMTP; 21 Feb 2008 22:30:57 +0100
X-Authenticated: #482760
X-Provags-ID: V01U2FsdGVkX1+QtmUWZJuQWrahuJzM7Z5alJ488JV/hmzT+yIJYj
	ADi5AgzAuAIR6n
User-Agent: KMail/1.9.5
In-Reply-To: <20080218140005.GA18668@diana.vm.bytemark.co.uk>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74660>

Hi,
> > instead of stg rename <old> <new>. This is for example helpful for
> > those people who always have a typo or two in their patch names.
> 
> Please follow the commit message conventions. That is, first one short
> summary line, then a blank line and the rest of the commit message.
> And a sign-off.

Ok, I tried to do this, I'm not used at all to sending patches with (st)git :-)
Thanks for the pointer and the assistance. Hopefully, --refid works as I 
understand it and the new patches appear in this thread.
 
> Please consider storing the patch names in two suitably named
> variables, like this:
I fixed that one, too.

I'll send out another patch, a test case for the stg rename command.

Greetings,

Onno
