From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git Screencast ?
Date: Fri, 23 Nov 2007 15:58:25 -0500
Message-ID: <20071123205825.GB14735@spearce.org>
References: <fi1a9f$30q$1@ger.gmane.org> <47453C6D.1080403@op5.se> <fi5bet$brl$1@ger.gmane.org> <20071123101426.GA15902@dualtron.vpn.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Donaghy <mike@mikedonaghy.org>, git@vger.kernel.org
To: Johannes Gilger <heipei@hackvalue.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 21:58:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivfbv-0006zN-Lt
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 21:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXKWU6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 15:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752844AbXKWU6b
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 15:58:31 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58606 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbXKWU6a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 15:58:30 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IvfbO-0005D8-AU; Fri, 23 Nov 2007 15:58:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 64D5920FBAE; Fri, 23 Nov 2007 15:58:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071123101426.GA15902@dualtron.vpn.rwth-aachen.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65927>

Johannes Gilger <heipei@hackvalue.de> wrote:
> On 22/11/07 20:47, Michael Donaghy wrote:
> > Yes thank you , although a screen cast would still be ideal , the 
> > documentation is very good,
> > also , what do you think of git-gui ? , I think it is the best one
> 
> I think you're trying to hide the complexity of git. The problem with 
> graphical tools is that they hide complexity from the user, which in 
> some cases is only possibly/good if the user has understood the 
> underlying principles already.

Actually some users have found that its easier to grok the index
by using git-gui.  You can more directly see the state of update
actions, and it is fairly easy to stage/unstage individual hunks
of files through git-gui.  Once you get that down then seeking
the same methods through the command line isn't too difficult,
many of the terms in git-gui are the same as the command line term,
to make the transition back and forth easier for the user.

-- 
Shawn.
