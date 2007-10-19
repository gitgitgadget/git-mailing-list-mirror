From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: gitk patch collection pull request
Date: Fri, 19 Oct 2007 01:28:23 -0400
Message-ID: <20071019052823.GI14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 07:28:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IikPZ-0007pl-Jn
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 07:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbXJSF22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 01:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbXJSF22
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 01:28:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47527 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbXJSF21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 01:28:27 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IikPI-0004bp-IW; Fri, 19 Oct 2007 01:28:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 84B8720FBAE; Fri, 19 Oct 2007 01:28:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61652>

The following changes since commit 719c2b9d926bf2be4879015e3620d27d32f007b6:
  Paul Mackerras (1):
        gitk: Fix bug causing undefined variable error when cherry-picking

are available in the git repository at:

  git://repo.or.cz:/git/spearce.git gitk

Jonathan del Strother (2):
      gitk: Added support for OS X mouse wheel
      Fixing gitk indentation

Sam Vilain (1):
      gitk: disable colours when calling git log

 gitk |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)


I'm carrying these in my pu branch but would like to move them up
into master.  My gitk branch is actually forked off your own gitk
repository and doesn't contain the git.git history so you should
be able to do a direct pull.

-- 
Shawn.
