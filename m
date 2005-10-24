From: Junio C Hamano <junkio@cox.net>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Mon, 24 Oct 2005 02:44:29 -0700
Message-ID: <7v3bmrqmf6.fsf@assigned-by-dhcp.cox.net>
References: <4352F4C9.1040703@catalyst.net.nz>
	<20051021005145.GB30889@pasky.or.cz>
	<200510202137.22311.dtor_core@ameritech.net>
	<4358597A.6000306@catalyst.net.nz>
	<7vu0f7u3xc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510231804430.10477@g5.osdl.org>
	<20051024075431.GY30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 11:46:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETysl-0003n7-4r
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 11:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVJXJob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 05:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVJXJob
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 05:44:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48824 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750821AbVJXJoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2005 05:44:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051024094416.SDUA1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 24 Oct 2005 05:44:16 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051024075431.GY30889@pasky.or.cz> (Petr Baudis's message of
	"Mon, 24 Oct 2005 09:54:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10538>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Oct 24, 2005 at 03:35:43AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> told me that...
>> Oh, the git merge is about a million times better than any silly weave 
>> merge with extra BonusPoints and MagicCapitalizedNames.
>> 
>> Why? Because if you want to be slow and careful, you can always just 
>> create the weave after-the-fact and do a weave merge.
>
> This doesn't make sense. Those silly weave merges only describe what to
> do with the weave to do the merge, not how you got the weave in the
> first place.

True, but it should not be a problem that is made harder for you
to solve by the fact that our repository is not based on weaves.

Unless an weave-based SCM comes with an integrated editor that
records line insertion and deletion user actions and forces
users to use that editor and nothing else, it also has to work
on two whole files (pre- and post-modification) in order to find
the matching lines and figure out the weave to record, on top of
the history before pre-modification image.  I think you have the
same information as they have to create the weave after the fact
for each commit in that sense.
