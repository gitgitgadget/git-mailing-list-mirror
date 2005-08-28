From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 22:45:05 -0700
Message-ID: <7virxqpqce.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
	<7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508271709530.23242@iabervon.org>
	<Pine.LNX.4.63.0508271855100.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 07:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9Fyo-0004rL-6o
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 07:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVH1FpI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 01:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVH1FpI
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 01:45:08 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:49613 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751118AbVH1FpH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Aug 2005 01:45:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050828054507.ECBK19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 28 Aug 2005 01:45:07 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508271855100.23242@iabervon.org> (Daniel
	Barkalow's message of "Sat, 27 Aug 2005 19:15:51 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7863>

Daniel Barkalow <barkalow@iabervon.org> writes:

> What I missed was that the effect of causes_df_conflict is to give "no
> merge" for the entry, rather than giving an error overall. So I do need an
> equivalent.

Correct.
