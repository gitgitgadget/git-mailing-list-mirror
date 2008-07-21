From: Peter Vun <pvun@ics.mq.edu.au>
Subject: cygwin git and network drives
Date: Mon, 21 Jul 2008 07:09:47 +0000 (UTC)
Message-ID: <loom.20080721T065829-347@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 09:16:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKpcv-0001G0-Pr
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 09:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYGUHPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 03:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbYGUHPI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 03:15:08 -0400
Received: from main.gmane.org ([80.91.229.2]:60212 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719AbYGUHPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 03:15:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KKpbq-0007vv-IQ
	for git@vger.kernel.org; Mon, 21 Jul 2008 07:15:03 +0000
Received: from CPE-61-9-196-200.static.nsw.bigpond.net.au ([61.9.196.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 07:15:02 +0000
Received: from pvun by CPE-61-9-196-200.static.nsw.bigpond.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 07:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 61.9.196.200 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89313>

Hi Guys, 

I'm currently testing Git on our office network and I noticed on 
the following site

http://git.or.cz/gitwiki/CygwinBinaryInstall

that is says

Use git on local NTFS disks -- Network drives disks don't support the
filesystem semantics GIT needs; for interoperability purposes you 
can store bare repositories on FAT32 disks.

Does anyone know if the above statement is still valid? Personally, I've 
tested cygwin Git with network drives a couple of times and I haven't 
encountered any problems, (yet!!). 

Any details on Git's limits with regards to this issue would be much
appreciated. 

Cheers
Peter
