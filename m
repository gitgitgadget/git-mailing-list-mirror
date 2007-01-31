From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Fail softly if file system does not like test data.
Date: Wed, 31 Jan 2007 01:14:37 +0100
Message-ID: <200701310114.38258.robin.rosenberg@dewire.com>
References: <20070130163219.GA14431@164.242.249.10.in-addr.arpa> <20070130224446.28311.31828.stgit@lathund.dewire.com> <64949F2D-6A6D-4373-8B7F-C8F75529CD2E@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 01:14:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC37B-0008Rf-Sx
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 01:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXAaAOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 19:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbXAaAN7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 19:13:59 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11739 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbXAaAN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 19:13:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 826EA80338F;
	Wed, 31 Jan 2007 01:09:18 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06173-06; Wed, 31 Jan 2007 01:09:18 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 413F1800199;
	Wed, 31 Jan 2007 01:09:18 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <64949F2D-6A6D-4373-8B7F-C8F75529CD2E@silverinsanity.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38217>

onsdag 31 januari 2007 00:28 skrev Brian Gernhardt:
> Doesn't work, but it's closer.  I can't see where a .gitignore is
> getting set, though.

I did not create any .gitignore files, so I have no explanation at this time.

-- robin
