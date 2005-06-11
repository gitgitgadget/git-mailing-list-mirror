From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: do people use the 'git' command?
Date: Sat, 11 Jun 2005 11:14:57 -0600
Message-ID: <E1Dh9ZR-0004xU-4q@highlab.com>
References: <E1DgodI-0003ov-Fl@highlab.com> <20050610185945.GB13102@vrfy.org>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 19:08:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh9TG-0002PH-Vb
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 19:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVFKRM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 13:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVFKRM7
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 13:12:59 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:18329 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261747AbVFKRMz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 13:12:55 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20050611171255014002f8a8e>; Sat, 11 Jun 2005 17:12:55 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1Dh9ZR-0004xU-4q; Sat, 11 Jun 2005 11:14:57 -0600
To: Kay Sievers <kay.sievers@suse.de>
In-reply-to: <20050610185945.GB13102@vrfy.org> 
Comments: In-reply-to Kay Sievers <kay.sievers@suse.de>
   message dated "Fri, 10 Jun 2005 20:59:45 +0200."
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kay Sievers <kay.sievers@suse.de> wrote:
> On Fri, Jun 10, 2005 at 12:53:32PM -0600, Sebastian Kuzminsky wrote:
> > What good is the 'git' command?  It's a shortcut to run the
> > "git-$FUNCTION-script" programs, but it doesnt do the "git-$FUNCTION"
> > programs.  It just doesnt seem worth its inode, to me.  And it doesnt seem
> > worth the pain to distribution maintainers (like me) to avoid the naming
> > conflict with GNU Interactive Tools' /usr/bin/git.
> 
> Well, drop the GNU Interactive Tools instead. We've removed it from the
> SuSE packages and have a "real" git package now. :)

That sounds nice!  If only it weren't for all those pesky users...


-- 
Sebastian Kuzminsky
