From: Rob Landley <rob@landley.net>
Subject: Re: Who do I report bugs in the git source web browser thing to?
Date: Thu, 23 Mar 2006 17:47:31 -0500
Message-ID: <200603231747.32166.rob@landley.net>
References: <200603231143.17762.rob@landley.net> <Pine.LNX.4.64.0603230856250.26286@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 23:47:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMYaY-0004mg-98
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 23:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbWCWWr1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 17:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWCWWr1
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 17:47:27 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:58535
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932538AbWCWWr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 17:47:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id k2O0WKrd015695;
	Thu, 23 Mar 2006 19:32:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8.3
In-Reply-To: <Pine.LNX.4.64.0603230856250.26286@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17881>

On Thursday 23 March 2006 12:03 pm, Linus Torvalds wrote:
> On Thu, 23 Mar 2006, Rob Landley wrote:
> Pick another file, like the Makefile, to see what real history looks like
> (or, better yet, go into a different directory that actually sees more
> real work, like kernel/, and look at the history of files there).

I was trying to find out when symlink support went in to gen_init_cpio.c, so 
that was the only file that interested me.  I forgot that the bitkeeper 
history never got moved over.

Thanks,

Rob
-- 
Never bet against the cheap plastic solution.
