From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: symbolic link management in git-archive
Date: Thu, 27 Mar 2008 11:29:28 +0000 (UTC)
Message-ID: <loom.20080327T112740-539@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 12:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeqJP-0006Tx-KI
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 12:30:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbYC0L3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 07:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbYC0L3q
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 07:29:46 -0400
Received: from main.gmane.org ([80.91.229.2]:48252 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534AbYC0L3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 07:29:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JeqIg-0004tQ-5A
	for git@vger.kernel.org; Thu, 27 Mar 2008 11:29:42 +0000
Received: from host45-62-dynamic.6-87-r.retail.telecomitalia.it ([87.6.62.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 11:29:42 +0000
Received: from sergio.callegari by host45-62-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Mar 2008 11:29:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.62.45 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.12) Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78344>

Hi,

I guess the answer is "no" or "not yet", but is there a way to tell the zip
backend of git-archive to follow symbolic links rather than to store them?

Sergio
