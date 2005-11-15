From: Junio C Hamano <junkio@cox.net>
Subject: Re: pushing patches to an imap folder
Date: Tue, 15 Nov 2005 01:12:01 -0800
Message-ID: <7vd5l2qnq6.fsf@assigned-by-dhcp.cox.net>
References: <43799A67.9030705@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 10:13:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbwrJ-0008IF-09
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 10:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVKOJMF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 04:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKOJME
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 04:12:04 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29888 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751402AbVKOJMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 04:12:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115091133.FIOD20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 04:11:33 -0500
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <43799A67.9030705@codeweavers.com> (Mike McCormack's message of
	"Tue, 15 Nov 2005 17:20:55 +0900")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11890>

Mike McCormack <mike@codeweavers.com> writes:

> I hacked up git-format-patch and isync to create a program to push 
> patches from git into an imap folder.  This improve my workflow with git 
> quite a bit.

Hmph.  How well does the rest of git help your workflow, working
with the Wine community?  Especially, how are you keeping track
of and interoperating with their main CVS repository?  Do you
have to do anything special when your patches are accepted by
the upstream and echoed back to you when you 'cvs update' from
them next time?
