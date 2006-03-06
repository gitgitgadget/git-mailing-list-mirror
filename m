From: Matt McCutchen <hashproduct@verizon.net>
Subject: Looking for SCM that lets me publish part of a repository
Date: Sun, 05 Mar 2006 20:31:19 -0500
Message-ID: <1141608679.16980.12.camel@mattlaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Mar 06 02:31:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4ZN-0004YO-Gn
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWCFBb0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWCFBb0
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:31:26 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:30346 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751499AbWCFBb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 20:31:26 -0500
Received: from [192.168.1.5] ([68.239.98.232])
 by vms040.mailsrvcs.net (Sun Java System Messaging Server 6.2-4.02 (built Sep
 9 2005)) with ESMTPA id <0IVO00BOAMWCTGKC@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 05 Mar 2006 19:31:25 -0600 (CST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17259>

Dear GIT people,

For the last week or so, I have been looking for a SCM system to hold
many of my projects, some of which are available to the public and
others of which are not.  It would be nice if I could use a single large
private repository on my computer with each project in a separate
folder.  Then I would like to pull some of the projects (but not all)
into a world-readable repository on my Web site.  I have looked at
several SCMs and have not found a way to make any of them do this, but I
like GIT best on other grounds.  Is there a way I can coerce GIT to
clone and pull one folder out of a repository but ignore the rest?
-- 
Matt McCutchen
hashproduct@verizon.net
http://hashproduct.metaesthetics.net/
