From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: (unknown)
Date: Mon,  6 Oct 2008 01:36:36 +0200
Message-ID: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 01:39:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmdCC-0003Jr-63
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 01:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbYJEXhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 19:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbYJEXhy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 19:37:54 -0400
Received: from av7-2-sn3.vrr.skanova.net ([81.228.9.182]:51255 "EHLO
	av7-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYJEXhy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 19:37:54 -0400
Received: by av7-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 7E43638924; Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av7-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 3FFF038705; Mon,  6 Oct 2008 01:37:51 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id CA3BF37E47;
	Mon,  6 Oct 2008 01:37:50 +0200 (CEST)
Subject: 
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97547>

This series decorates the graphical and text (jgit log) history listings
with tags. For the text command it is optional.

Reviewers may want to pay special attention to the changes in the Ref class.

-- robin
