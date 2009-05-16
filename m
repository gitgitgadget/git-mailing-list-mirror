From: Peter CHARRON <pcharron@itelliseek.com>
Subject: Simple rollback or discard of un-commited changes
Date: Fri, 15 May 2009 19:00:01 -0700
Message-ID: <025F1C6D-1CAE-42BD-986B-1B53238882DE@itelliseek.com>
Mime-Version: 1.0 (Apple Message framework v930.4)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 16 04:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M59Pp-00020s-R7
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 04:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754287AbZEPCLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 22:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZEPCLy
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 22:11:54 -0400
Received: from itelliseek.com ([65.49.29.129]:36689 "HELO itelliseek.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753937AbZEPCLx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 22:11:53 -0400
X-Greylist: delayed 713 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2009 22:11:53 EDT
Received: from ::ffff:67.188.29.119 ([67.188.29.119]) by itelliseek.com for <git@vger.kernel.org>; Fri, 15 May 2009 19:00:01 -0700
X-Mailer: Apple Mail (2.930.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119315>

I've used a lot of Source Code Control systems, but I can't figure out  
how to do a simple discard (aka rollback) of one file using GIT.

What am I missing?
