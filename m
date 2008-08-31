From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH] Select all changes in repository for commit by default
Date: Sun, 31 Aug 2008 11:38:42 +0200
Message-ID: <1220175524-1523-1-git-send-email-robin.rosenberg@dewire.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 11:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZjRn-000794-Ct
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 11:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbYHaJlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756474AbYHaJlJ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 05:41:09 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7395 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756230AbYHaJlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 05:41:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 651D88027F4;
	Sun, 31 Aug 2008 11:41:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 86wSfD9f2fMh; Sun, 31 Aug 2008 11:41:05 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id BBBF180068E;
	Sun, 31 Aug 2008 11:41:05 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc2.35.g04c6e9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94469>

This is an old patch series, previously send under the subject [EGIT RFC] Commit behaviour
now squash and it seems to work with Eclipse 3.4 too.

>This tentative feature allows me to hit the commit button
>when any resource is selected and figure out which resources have been
>modified. This makes it much easier to commit. Only the toolbar commit
>is affected for now.

-- robin
