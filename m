From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git bash completion updates for 1.5.3
Date: Thu, 23 Aug 2007 01:54:35 -0400
Message-ID: <20070823055435.GQ27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 07:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5eV-0006ZU-3j
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 07:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXHWFyk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 01:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751859AbXHWFyk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 01:54:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56569 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbXHWFyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 01:54:39 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IO5eP-000308-3k; Thu, 23 Aug 2007 01:54:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2136720FBAE; Thu, 23 Aug 2007 01:54:35 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56455>

The following changes since commit aabb2e515c334cbca9d9ae9873a188cef2c9b3ba:
  Eric Wong (1):
        git-svn: update documentation with CAVEATS section

are available in the git repository at:

  repo.or.cz:/srv/git/git/fastimport.git master

Shawn O. Pearce (3):
      Update bash completion with new 1.5.3 command line options
      Teach bash to complete ref arguments to git-describe
      Teach bash about git-submodule and its subcommands

 contrib/completion/git-completion.bash |   67 +++++++++++++++++++++++++++++---
 1 files changed, 61 insertions(+), 6 deletions(-)


Mostly really really trivial stuff.

-- 
Shawn.
