From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Prototype git commit viewer
Date: Mon, 9 May 2005 09:13:41 +0200
Message-ID: <20050509071341.GA3599@pasky.ji.cz>
References: <17022.49021.344841.79940@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 09:06:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV2Lf-0006qu-WB
	for gcvg-git@gmane.org; Mon, 09 May 2005 09:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbVEIHNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 03:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVEIHNp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 03:13:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5609 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S263068AbVEIHNn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 03:13:43 -0400
Received: (qmail 6990 invoked by uid 2001); 9 May 2005 07:13:41 -0000
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17022.49021.344841.79940@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 03:40:13AM CEST, I got a letter
where Paul Mackerras <paulus@samba.org> told me that...
> Over the weekend I hacked up a prototype viewer for git commits in
> Tk.  It's called gitk and is at:
> 
> 	http://ozlabs.org/~paulus/gitk
> 
> (that's the actual script itself :).
> 
> It displays a window with two panes; the upper one shows a summary of
> all the commits with a graph on the left showing the relationship of
> the commits (each dot represents a commit, with lines joining parents
> and children).  The list is displayed with the most recent commit at
> the top, and parents below their children.
> 
> If you click on a commit, the bottom pane shows more details of the
> commit including the commit comments.
> 
> I plan to add a pane to show the list of files changed by the commit,
> and provide a way to pop up a dirdiff-style diff viewer window to view
> the actual diffs.  I also plan to add a way to view the diffs between
> arbitrary points in the graph using girdiff.  There is quite a lot of
> UI tweaking to be done too.  However, it's already quite useful in its
> current state.

What are its advantages to git-viz?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
