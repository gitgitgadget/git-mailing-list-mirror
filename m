From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Add shortcut keys for Show More/Less Context
Date: Sat, 29 Mar 2008 01:44:40 -0400
Message-ID: <20080329054440.GP4759@spearce.org>
References: <57518fd10803280622v3a5f6ae8lcfd35270ab9ede1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 06:45:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfTsr-0004EC-JE
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 06:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbYC2Foq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 01:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbYC2Foq
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 01:44:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44699 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYC2Fop (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 01:44:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JfTru-0003hb-B7; Sat, 29 Mar 2008 01:44:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EC46820FBAE; Sat, 29 Mar 2008 01:44:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <57518fd10803280622v3a5f6ae8lcfd35270ab9ede1e@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78446>

Jonathan del Strother <maillist@steelskies.com> wrote:
> Bound to Ctrl/Cmd (depending on your platform) + left & right square brackets.
> ---
> 
> I'm not at all familiar with Tcl, so I apologise in advance for any
> wrongness.  I frequently find myself repeatedly right-clicking->Show
> Less Context in order to stage a specific hunk, seems like a shortcut
> for this would be useful.  Thoughts?

Looks good to me.  FWIW your patch was sent with a content-type of
format=flawed, so I had to manually unwrap the diff hunk headers
to get it to apply.

I think we should also put these into the menu bar too, like say
the commit menu, so users can see what the keyboard action is to
invoke the increase/decrease.

Also, missing a Signed-off-by line.  If you can contribute
this change according to the statement outlined in
Documentation/SubmittingPatches please send me one.
 
-- 
Shawn.
