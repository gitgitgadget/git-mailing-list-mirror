From: Nickolai Leschov <nleschov@gmail.com>
Subject: fatal: Unable to find remote helper for 'https'
Date: Thu, 9 Feb 2012 21:51:30 +0000 (UTC)
Message-ID: <loom.20120209T224147-400@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 22:55:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvbxQ-0004IY-HW
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 22:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266Ab2BIVzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 16:55:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:52892 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757787Ab2BIVzG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 16:55:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RvbxH-0004D9-UK
	for git@vger.kernel.org; Thu, 09 Feb 2012 22:55:04 +0100
Received: from ip-94-229-98-4.pntl.ru ([ip-94-229-98-4.pntl.ru])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 22:55:03 +0100
Received: from nleschov by ip-94-229-98-4.pntl.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 22:55:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 94.229.98.4 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.11) Gecko/20101013 Ubuntu/9.04 (jaunty) Firefox/3.6.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190332>

Hello,

I have compiled git 1.7.9 from source on Ubuntu 9.04 and I get the following
message when cloning a git repo:

fatal: Unable to find remote helper for 'https'

I get this message when I try to use https; or similar one for http. Only
cloning via git:// protocol works. My system is Ubuntu 9.04 i386. git 1.7.9 and
two previous versions I tried all exhibit this problem. I have uninstalled the
git that comes in Ubuntu repositories and build from source instead because I
need a newer version.

How can I make git work on that system?

I have another system with Ubuntu 11.04 i386 and it there git 1.7.4.1 (from
repositories) doesn't exhibit such problem.

Best regards,

Nickolai Leschov
