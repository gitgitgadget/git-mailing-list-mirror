From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: This week in EGIT - more tags
Date: Mon, 14 May 2007 01:39:13 +0200
Message-ID: <11790995572233-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon May 14 01:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNyH-00061r-B4
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650AbXEMX7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758505AbXEMX7T
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:59:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:23502 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758388AbXEMX7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:59:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E44B78027ED;
	Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06019-07; Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 242B18028BE;
	Mon, 14 May 2007 01:32:59 +0200 (CEST)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id 7681B28677; Mon, 14 May 2007 01:39:17 +0200 (CEST)
X-Mailer: git-send-email 1.5.1.1
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47196>

I thought the previous batch was the last 'safe' one, but this one proably
is too as it only adds display of tags and branch to the history view and
no user accessible modifying codde. 

In order to do that I had to teach the core more about funny tags and packed
refs.

-- robin
