From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Mon, 26 May 2008 00:46:40 -0400
Message-ID: <20080526044640.GB30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Dave Watson <dwatson@mimvista.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 26 06:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0Uch-0002AQ-Mb
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 06:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbYEZEqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 00:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbYEZEqt
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 00:46:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49740 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbYEZEqs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 00:46:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K0Ubd-0001Nz-Hn; Mon, 26 May 2008 00:46:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D770220FBAE; Mon, 26 May 2008 00:46:40 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82898>

As of 53a2cc3 the jgit library (a 100% pure Java implementation
of git) is now licensed under a 3-clause (new-style) BSD license.
The change was done with a Perl script to rewrite all source code
headers within the org.spearce.jgit package.  Copyright information
was updated based upon the output of git-blame.

The change is here:

	git://repo.or.cz/egit/spearce.git bsd

and is based upon the the thread that I started on this list:

	http://article.gmane.org/gmane.comp.version-control.git/81585

If there are no objections within the next couple of days we'll
merge it to the main tree.

-- 
Shawn.
