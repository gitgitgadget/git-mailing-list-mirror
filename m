From: Marcel Holtmann <marcel@holtmann.org>
Subject: No tags when cloing the Linux history tree
Date: Wed, 31 May 2006 19:23:12 +0200
Message-ID: <1149096192.2152.37.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Wed May 31 19:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlUPM-0004YX-T9
	for gcvg-git@gmane.org; Wed, 31 May 2006 19:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbWEaRW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 13:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbWEaRW5
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 13:22:57 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:21893 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751744AbWEaRW5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 13:22:57 -0400
Received: from blade (p5487DBD8.dip.t-dialin.net [84.135.219.216])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3sarge1) with ESMTP id k4VHOQHZ019782
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT);
	Wed, 31 May 2006 19:24:26 +0200
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.1 
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_96_XX 
	autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on coyote.holtmann.net
X-Virus-Scanned: ClamAV 0.84/1501/Wed May 31 12:23:26 2006 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21071>

Hi guys,

when cloning the Linux history tree from Thomas Gleixner over HTTP or
GIT transports using cg-clone (instead of git-clone), I don't get the
tags. I checked on master.kernel.org and all tags are present there.

Regards

Marcel
