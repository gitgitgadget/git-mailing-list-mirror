From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 0/2] *** SUBJECT HERE ***
Date: Wed, 17 Dec 2008 01:07:17 +0100
Message-ID: <1229472439-24104-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Dec 17 01:09:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCjyY-0001p4-6U
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 01:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760026AbYLQAHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 19:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760002AbYLQAHc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 19:07:32 -0500
Received: from mail.dewire.com ([83.140.172.130]:4313 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759851AbYLQAHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 19:07:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5390A147E529;
	Wed, 17 Dec 2008 01:07:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Udw+tp6Tyzel; Wed, 17 Dec 2008 01:07:20 +0100 (CET)
Received: from localhost.localdomain (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id E5902147E51F;
	Wed, 17 Dec 2008 01:07:19 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.640.g6331a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103298>

The few plugin unit tests we have is a sad story. Cheer up a bit.

Robin Rosenberg (2):
  Revert "Fix commit id in egit test
    T0001_ConnectProviderOperationTest"
  Fixed an old failed EGit unit test.

 .../egit/core/internal/mapping/T0002_history.java  |    5 ++---
 .../op/T0001_ConnectProviderOperationTest.java     |    3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)
