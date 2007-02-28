From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT PATCH 0/9] Misc minor fixes
Date: Wed, 28 Feb 2007 23:26:04 +0100
Message-ID: <20070228222355.12021.13029.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 23:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMXLc-0002xY-7K
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 23:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXB1WcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXB1WcK
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 17:32:10 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1416 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932569AbXB1WcI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 17:32:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B2CFF8033AB
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18351-03 for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:27:00 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 59CAB80339F
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:58 +0100 (CET)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 6AD1C29862
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id WU4g6+IenHc7 for <git@vger.kernel.org>;
	Wed, 28 Feb 2007 23:26:05 +0100 (CET)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 120A729859
	for <git@vger.kernel.org>; Wed, 28 Feb 2007 23:26:05 +0100 (CET)
User-Agent: StGIT/0.11
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41015>

This is a set of smaller fixes necessary to implement larger
features ( to be submitted later on ).

-- robin
