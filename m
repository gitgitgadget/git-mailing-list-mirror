From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 22:46:06 -0700
Message-ID: <7vd5nypqap.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
	<7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508271709530.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 07:46:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Fzh-0004uo-75
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 07:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVH1FqK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 01:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVH1FqK
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 01:46:10 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:995 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751126AbVH1FqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 01:46:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828054607.JUYV16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 01:46:07 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508271709530.23242@iabervon.org> (Daniel
	Barkalow's message of "Sat, 27 Aug 2005 17:57:29 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7864>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'd actually like to introduce Documentation/technical/trivial-merge for
> this stuff; I think it would be good to have documentation for people who
> need to know how the stuff works, rather than just how to use it, so we
> get a balance between reams of information that users don't want to wade
> through and being too vague for future developers.

I think that is an excellent idea to have user manual vs
internals manual.
