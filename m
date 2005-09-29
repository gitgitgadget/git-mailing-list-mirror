From: Jeff Garzik <jgarzik@pobox.com>
Subject: [howto] Kernel hacker's guide to git, updated
Date: Thu, 29 Sep 2005 07:03:05 -0400
Message-ID: <433BC9E9.6050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932103AbVI2LDM@vger.kernel.org Thu Sep 29 13:04:29 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932103AbVI2LDM@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKwCU-0002px-ED
	for glk-linux-kernel-3@gmane.org; Thu, 29 Sep 2005 13:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVI2LDM (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Sep 2005 07:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVI2LDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 07:03:12 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3050 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932095AbVI2LDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 07:03:11 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EKwBw-0002Bw-Rw; Thu, 29 Sep 2005 11:03:11 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linux Kernel <linux-kernel@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9483>


Just updated my KHGtG to include the latest goodies available in 
git-core, the Linux kernel standard SCM tool:

	http://linux.yyz.us/git-howto.html

Several changes in git-core have made working with git a lot easier, so 
be sure to re-familiarize yourself with the development process.

Comments, corrections, and notes of omission welcome.  This document 
mainly reflects my typical day-to-day git activities, and may not be 
very applicable outside of kernel work.

	Jeff
