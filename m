From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [StGIT PATCH] (Repost) Command to move a patch to the top
Date: Thu, 05 Oct 2006 23:09:45 +0200
Message-ID: <20061005210945.16972.397.stgit@lathund.dewire.com>
References: <20061003213453.26195.54830.stgit@lathund.dewire.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Oct 05 23:14:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVaXi-0001yO-Oc
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 23:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWJEVOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWJEVOH
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 17:14:07 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19304 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751299AbWJEVOC
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Oct 2006 17:14:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 1700280289F
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:11:06 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15158-02 for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:11:05 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by torino.dewire.com (Postfix) with ESMTP id CF1FF802676
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:11:03 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 4D25429006
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:14:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id I5NoSKZ8p5Ou for <git@vger.kernel.org>;
	Thu,  5 Oct 2006 23:14:26 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id A688428F96
	for <git@vger.kernel.org>; Thu,  5 Oct 2006 23:14:26 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: StGIT/0.10
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28370>

This is a repost of a proposed StGIT command that I find useful. The
previous patch was broken. 

-- robin
