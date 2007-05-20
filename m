From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGit PATCH 0/2] Bash prompt updates
Date: Sun, 20 May 2007 22:03:57 +0200
Message-ID: <20070520200113.14633.90705.stgit@lathund.dewire.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: <20070506150852.8985.98091.stgit@yoghurt.dewire.com>
X-From: git-owner@vger.kernel.org Sun May 20 22:04:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hprdi-0000jm-Cf
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbXETUES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755898AbXETUER
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:04:17 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14979 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755773AbXETUER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:04:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A66898028AB;
	Sun, 20 May 2007 21:57:57 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25225-04; Sun, 20 May 2007 21:57:57 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 593B9800783;
	Sun, 20 May 2007 21:57:57 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id B59182936C;
	Sun, 20 May 2007 22:04:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id KJf+CPvKqZ3q; Sun, 20 May 2007 22:03:58 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id EDB9328B47;
	Sun, 20 May 2007 22:03:57 +0200 (CEST)
In-Reply-To: <20070506150852.8985.98091.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47899>

Here is a fix to update the bash prompt so it does not
use the obsolete current file anymore.

Part 2 is my version which uses a different format, mostly
because '/' can be part of the branch name.

-- robin
