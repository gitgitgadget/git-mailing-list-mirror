From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Won't append '/' to an empty repo relative path.
Date: Fri, 28 Sep 2007 21:15:21 +0200
Message-ID: <200709282115.22310.robin.rosenberg.lists@dewire.com>
References: <20070928043957.GA18592@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbLH8-0003CC-81
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 21:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbXI1TNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 15:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbXI1TNO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 15:13:14 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4788 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751647AbXI1TNN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 15:13:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 474FF8026E8;
	Fri, 28 Sep 2007 21:04:54 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25854-08; Fri, 28 Sep 2007 21:04:54 +0200 (CEST)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 0AB608003E1;
	Fri, 28 Sep 2007 21:04:54 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070928043957.GA18592@falcon.digizenstudio.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59417>

fredag 28 september 2007 skrev Jing Xue:
> 
> When the repo relative path is empty, the extra "/" causes all subsequent
> "startsWith" tests to fail.
> 

Thank you.

Please cc me in the future.

--- robin
