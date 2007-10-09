From: Sven Herzberg <sven@imendio.com>
Subject: Proposed command: git-sync
Date: Tue, 09 Oct 2007 21:26:07 +0200
Message-ID: <470BD5CF.9050201@imendio.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030505090204060100060407"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 21:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfL1F-0001LM-RR
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 21:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbXJITpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbXJITpM
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 15:45:12 -0400
Received: from holken.mikan.net ([83.145.56.183]:32769 "EHLO holken.mikan.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073AbXJITpL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 15:45:11 -0400
X-Greylist: delayed 1135 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Oct 2007 15:45:11 EDT
Received: from localhost (localhost [127.0.0.1])
	by holken.mikan.net (Postfix) with ESMTP id 67BE414571
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 21:26:12 +0200 (CEST)
Received: from holken.mikan.net ([127.0.0.1])
	by localhost (holken.mikan.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26889-04 for <git@vger.kernel.org>;
	Tue, 9 Oct 2007 21:26:09 +0200 (CEST)
Received: from [192.168.2.102] (p548FBD7B.dip.t-dialin.net [84.143.189.123])
	by holken.mikan.net (Postfix) with ESMTP id 8D41D11E9C
	for <git@vger.kernel.org>; Tue,  9 Oct 2007 21:26:09 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.13 (X11/20070824)
X-Virus-Scanned: Debian amavisd-new at holken.mikan.net
X-Spam-Status: No, score=-97.466 tagged_above=-999 required=4
	tests=[AWL=0.446, RCVD_IN_SORBS_DUL=2.088, USER_IN_WHITELIST=-100]
X-Spam-Score: -97.466
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60432>

This is a multi-part message in MIME format.
--------------030505090204060100060407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I really regularly find myself typing git pull directly after git push.
That's why I write a small shell script that might be added to the stock
git distribution.

Regards,
  Sven

PS: Please add me to the CC of your replies, I don't read this list.

--------------030505090204060100060407
Content-Type: text/plain;
 name="git-sync"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-sync"

IyEvYmluL2Jhc2gKCmdpdCBwdXNoICYmIGdpdCBwdWxsCg==
--------------030505090204060100060407--
