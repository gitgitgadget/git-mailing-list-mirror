From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #01; Mon, 06)
Date: Mon, 6 Oct 2008 15:48:49 -0500
Organization: Exigence
Message-ID: <20081006154849.6317f314.stephen@exigencecorp.com>
References: <20081006165943.GG8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 06 22:50:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmx28-0004L9-Ja
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 22:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909AbYJFUsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 16:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbYJFUsx
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 16:48:53 -0400
Received: from smtp202.sat.emailsrvr.com ([66.216.121.202]:60537 "EHLO
	smtp202.sat.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbYJFUsw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 16:48:52 -0400
Received: from relay10.relay.sat.mlsrvr.com (localhost [127.0.0.1])
	by relay10.relay.sat.mlsrvr.com (SMTP Server) with ESMTP id DA32A11B35E1;
	Mon,  6 Oct 2008 16:48:50 -0400 (EDT)
Received: by relay10.relay.sat.mlsrvr.com (Authenticated sender: stephen-AT-exigencecorp.com) with ESMTP id 7679611B35BC;
	Mon,  6 Oct 2008 16:48:50 -0400 (EDT)
In-Reply-To: <20081006165943.GG8203@spearce.org>
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97627>


> * sh/maint-rebase3 (Sun Oct 5 23:26:52 2008 -0500) 1 commit
>  - rebase--interactive: fix parent rewriting for dropped commits
> 
> A replacement for sh/maint-intrebase.  Its in pu because I have
> gotten 3 different versions of this patch, two of them posted a
> full 4 days after I merged the first version into next.  I felt
> burned by the patch author for not keeping up with my tree, so I'm
> not merging the patch to next.
>
> At this point its going to sit in pu until Junio comes back.
> I think the topic needs a few more days to settle to see if the
> patch author is going to submit any more revisions.

All fair enough.

Sorry for not keeping up with your tree--this was the first I heard my
first patch had made it into next, so I kept submitting new ones not
really knowing why they weren't generating feedback. My fault for not
actively looking into the pu/next thing--I'll know what to do next time.

Thanks,
Stephen
