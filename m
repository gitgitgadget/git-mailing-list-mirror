From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT v1.5.1-rc1
Date: Mon, 19 Mar 2007 18:08:35 -0700
Message-ID: <7v7itcd8mk.fsf@assigned-by-dhcp.cox.net>
References: <20070306063501.GA24355@spearce.org>
	<7v1wk2ua55.fsf@assigned-by-dhcp.cox.net>
	<20070306071630.GB24004@spearce.org>
	<7vtzwyprr7.fsf_-_@assigned-by-dhcp.cox.net>
	<7v8xdth5c4.fsf_-_@assigned-by-dhcp.cox.net>
	<17918.36447.419632.224014@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 02:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTSqK-0000m0-SM
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 02:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030825AbXCTBIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 21:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030829AbXCTBIh
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 21:08:37 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:35576 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030825AbXCTBIg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 21:08:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320010836.XCFI24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 21:08:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cp8b1W00S1kojtg0000000; Mon, 19 Mar 2007 21:08:35 -0400
In-Reply-To: <17918.36447.419632.224014@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 19 Mar 2007 07:21:35 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42688>

Bill Lear <rael@zopyra.com> writes:

> On Monday, March 19, 2007 at 03:53:47 (-0700) Junio C Hamano writes:
>>...
>>* Hooks
>>
>>  - The sample update hook to show how to send out notification
>>    e-mail was updated to show only new commits that appeared in
>>    the repository.  Earlier, it showed new commits that appeared
>>    on the branch.
>
> I did not see Shawn's changes to the update hooks in here, and can't
> recall where these stand at the moment --- will these be forthcoming?

Do you mean "[PATCH] Split sample update hook into post-receive
hook"?  My impression was that the discussion that followed made
its interface obsolete with later 8-patch series from Shawn.
