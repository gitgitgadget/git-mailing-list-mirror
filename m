From: Jeff Garzik <jgarzik@pobox.com>
Subject: does git prune packs?
Date: Wed, 14 Sep 2005 07:13:42 -0400
Message-ID: <432805E6.6030905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Sep 14 13:15:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFVDU-0003sc-9O
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 13:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbVINLON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 07:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932728AbVINLON
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 07:14:13 -0400
Received: from mail.dvmed.net ([216.237.124.58]:57260 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932726AbVINLOM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 07:14:12 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EFVDI-00028H-JQ
	for git@vger.kernel.org; Wed, 14 Sep 2005 11:14:08 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8517>


Does git-prune-packed eliminate packs that have been superceded by other 
packs?

	Jeff
