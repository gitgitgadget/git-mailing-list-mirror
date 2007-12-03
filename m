From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's in git-gui.git
Date: Sun, 2 Dec 2007 23:10:10 -0500
Message-ID: <20071203041010.GT14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 03 05:10:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz2dj-0002SP-WC
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 05:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbXLCEKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 23:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499AbXLCEKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 23:10:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42562 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbXLCEKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 23:10:14 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iz2d7-0008NC-3M; Sun, 02 Dec 2007 23:10:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2331420FBC9; Sun,  2 Dec 2007 23:10:11 -0500 (EST)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66857>

The following changes since gitgui-0.9.0 are now in my git-gui
master branch.  I'm considering tagging a 0.9.1 release next week.

 gitweb:  http://repo.or.cz/w/git-gui.git
 clone:   git://repo.or.cz/git-gui.git
          http://repo.or.cz/r/git-gui.git

----

Christian Stimming (2):
      Update git-gui.pot with latest (few) string additions and changes.
      Update German translation. 100% completed.

Johannes Sixt (1):
      git-gui: Improve the application icon on Windows.

Michele Ballabio (2):
      git-gui: fix a typo in lib/commit.tcl
      git-gui: update it.po and glossary/it.po

Robert Schiele (1):
      git-gui: install-sh from automake does not like -m755

brian m. carlson (1):
      git-gui: Reorder msgfmt command-line arguments

-- 
Shawn.
