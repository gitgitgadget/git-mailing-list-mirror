From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 22:27:16 -0800
Message-ID: <7vwtfxm917.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org>
	<200602142230.11442.Josef.Weidendorfer@gmx.de>
	<7v7j7xr54u.fsf@assigned-by-dhcp.cox.net> <43F26129.4040804@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 07:27:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9G8I-00029U-57
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 07:27:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423000AbWBOG1T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 01:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWBOG1T
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 01:27:19 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:61598 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932376AbWBOG1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2006 01:27:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060215062556.IQXT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Feb 2006 01:25:56 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F26129.4040804@op5.se> (Andreas Ericsson's message of "Wed, 15
	Feb 2006 00:00:57 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16214>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>
>> Now, read-only ref does not interest me, but "do not commit on
>> top of this yourself, only fast-forward from somewhere else is
>> allowed" may be useful, for the reason why you mentioned
>> "origin".
>
> Do my suggestion and you wouldn't have to worry about read-only
> branches, and although merging any changes from it might be more
> trouble than its worth, it might be possible to cherry-pick the commit
> rather than reverting and re-applying it.

Sorry, is this "do my suggestion" a solution to my "do not
commit on top of this yourself, only fast-forward from somewhere
else is allowed -- e.g. to protect 'origin'" issue, or is it
something completely different?
