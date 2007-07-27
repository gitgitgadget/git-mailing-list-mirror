From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui problem with version number.
Date: Fri, 27 Jul 2007 00:46:34 -0400
Message-ID: <20070727044634.GG20052@spearce.org>
References: <86odhzpg2l.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:46:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHj0-0000if-FT
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbXG0Eqi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbXG0Eqi
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:46:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50783 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbXG0Eqi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:46:38 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEHil-0002gb-NW; Fri, 27 Jul 2007 00:46:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A14F520FBAE; Fri, 27 Jul 2007 00:46:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <86odhzpg2l.fsf@lola.quinscape.zz>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53884>

David Kastrup <dak@gnu.org> wrote:
> Hi, git-gui does not get along with the creativeness in git
> versioning:

What version of git-gui?  gitgui-0.7.5-67-g91464df and later have
fixes to handle all of the fun cases in git versioning.  Like the
one you have here.
 
> git-gui
> Error in startup script: expected version number but got "1.5.3.rc2.4.g726f9-dirty"
>     while executing
> "package vcompare $_git_version $vr"

-- 
Shawn.
