From: Kaushalya Satharasinghe <kaushalyas@zone24x7.com>
Subject: Unable to connect to the server
Date: Fri, 21 Sep 2007 15:10:36 +0600
Organization: Zone24x7
Message-ID: <1190365837.5497.4.camel@localhost>
Reply-To: kaushalyas@zone24x7.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 01:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJrs-000052-In
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbXIYXa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbXIYXa5
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:30:57 -0400
Received: from relay6.slt.lk ([203.115.0.21]:39562 "EHLO relay6.slt.lk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbXIYXa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:30:56 -0400
X-Greylist: delayed 45665 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2007 19:30:56 EDT
Received: from [192.168.1.140] (localhost [127.0.0.1])
	by relay6.slt.lk (8.13.4/8.13.4) with ESMTP id l8PAokau018586
	for <git@vger.kernel.org>; Tue, 25 Sep 2007 16:21:00 +0530 (LKT)
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59195>

Hi,

I want to checkout a git package. I installed git and when I give the
command
"/root/bin/git clone
git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git /home/Kaushalya/moreWork/git_test
"
I got the result as

Initialized empty Git repository
in /home/Kaushalya/moreWork/git_test/.git/
git.kernel.org[0: 140.211.167.38]: errno=Connection timed out
fatal: unable to connect a socket (Connection timed out)
fetch-pack from
'git://git.kernel.org/pub/scm/linux/kernel/git/drzeus/mmc.git' failed.

I can ping the 140.211.167.38. I am using Fedora Core 5 hosted through
vmware 5.5. Can anyone help me out here?

Thanks and regards,
-- 
Kaushalya Satharasinghe <kaushalyas@zone24x7.com>
Zone24x7
