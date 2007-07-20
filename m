From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC status report
Date: Fri, 20 Jul 2007 04:34:01 -0400
Message-ID: <20070720083401.GQ32566@spearce.org>
References: <200707201024.35605.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 10:34:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBnwI-0007QD-B0
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 10:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbXGTIeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 04:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763514AbXGTIeK
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 04:34:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54222 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933819AbXGTIeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 04:34:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IBnw1-0000EG-2z; Fri, 20 Jul 2007 04:34:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1BEB020FBAE; Fri, 20 Jul 2007 04:34:02 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200707201024.35605.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53070>

Jakub Narebski <jnareb@gmail.com> wrote:
> How it goes with Google Summer of Code git projects:
> builtinification,

Carlos is making good progress, he's had a few versions of git-tag
posted, and incorporated feedback into it.  Hopefully we'll see that
finialize and merge into Junio's tree in the not-too-distant future.

> libification

Luiz and I have have been working mostly off-list on this, as we
wanted to get something solid that the list can actually look at
and comment on, rather than just speculate.  Luiz has something he's
just about ready to share with us, and may post about it next week.
I don't want to steal his thunder, so I'm staying quiet on the
topic for now.  ;-)

> and GitTorrent?

Unfortuantely this isn't a project under GSoC anymore.  The student
involved had some issues with being able to get his paperwork
completed for Google and was not able to participate this summer.
I have not heard much more than that.
 
> I can see that builtinification (and perhaps libification) goes quite 
> well; what about GitTorrent project? Does anybody know how Mono SoC 
> project: "Managed C# git implementation" goes?

I haven't heard anything on it, or looked into it since the start.
I did reach out to both the student and Miguel, and got responses
back from them at that time, but have not heard anything since.
A Google search turned up the Mono GSoC status update mailing list,
which has weekly posts from a bunch of other Mono related projects,
but none about the C# Git implementation.  I'm suspecting maybe it
is dead.

-- 
Shawn.
