From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: RFD Use git for off-site backups
Date: Sun, 13 May 2007 19:42:54 -0400
Message-ID: <20070513234254.GN3141@spearce.org>
References: <20070513093417.GA18546@cip.informatik.uni-erlangen.de> <20070513123436.GE8983@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <thomas@glanzmann.de>, GIT <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon May 14 01:43:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNiY-000407-30
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbXEMXnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756218AbXEMXnF
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:43:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53006 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169AbXEMXnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:43:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HnNiA-0004Mr-94; Sun, 13 May 2007 19:42:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2184520FBAE; Sun, 13 May 2007 19:42:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070513123436.GE8983@efreet.light.src>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47195>

Jan Hudec <bulb@ucw.cz> wrote:
>  - Use Subversion. There is summer of code project to create git-svnserver,
>    so you might be able to use git on the server-side in future with
>    subversion client too. But for backups you should not need any of the
>    version control features subversion does not have, so subversion should be
>    suitable.

Unfortunately Google is not sponsering the git-svnserver summer of
code project.  We didn't get enough slots for us to get Google to
pay for that one.  At least one of the students has still expressed
interest in working on it, but it won't be their full-time job this
summer. :-(

-- 
Shawn.
