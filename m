From: Marcel Holtmann <marcel@holtmann.org>
Subject: Problem with cg-diff <file>
Date: Mon, 30 May 2005 01:15:55 +0200
Message-ID: <1117408555.7072.109.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 01:14:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcWyP-0004p8-Nq
	for gcvg-git@gmane.org; Mon, 30 May 2005 01:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVE2XP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 19:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVE2XP7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 19:15:59 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:32442 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261386AbVE2XP4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 19:15:56 -0400
Received: from pegasus (p5487D5D5.dip.t-dialin.net [84.135.213.213])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4TNHgSs023740
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 30 May 2005 01:17:43 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Petr,

your latest changes are breaking the cg-diff <file> functionality. Now
cg-diff creates a diff against all local not committed changes.

Regards

Marcel


