From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/3] jgit glog alignment fixes
Date: Wed,  1 Oct 2008 21:31:30 +0200
Message-ID: <1222889493-12736-1-git-send-email-robin.rosenberg@dewire.com>
References: <20081001143815.GV21310@spearce.org>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Oct 01 21:34:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl7Sg-0007Lh-MU
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 21:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbYJATcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753806AbYJATcl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 15:32:41 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:49670 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbYJATck (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 15:32:40 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id E7700386CE; Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 861843843F; Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
Received: from localhost.localdomain (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 5F27437E43;
	Wed,  1 Oct 2008 21:32:38 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.310.gf789d0.dirty
In-Reply-To: <20081001143815.GV21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97255>

The series resent based upon review comments. Drop the unnecessary dispose
calls for system allocated colors (and thus all SWT related changed).

-- robin
