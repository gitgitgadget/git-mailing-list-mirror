From: Michal Vitecek <fuf@mageo.cz>
Subject: [RFH] how to know if a cherry-picked patch has been applied
	already?
Date: Fri, 11 Jan 2008 11:47:37 +0100
Message-ID: <20080111104737.GA7332@mageo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:11:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDHnM-0000o4-00
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 12:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbYAKLLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 06:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbYAKLK7
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 06:10:59 -0500
Received: from interactive-1.com ([193.85.232.82]:40192 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbYAKLK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 06:10:59 -0500
X-Greylist: delayed 1400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2008 06:10:59 EST
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 802992D3BE6
	for <git@vger.kernel.org>; Fri, 11 Jan 2008 11:47:38 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70145>

 Hello everyone,

 I'm managing a git repository where I include my and my co-workers'
 work. With some co-workers I can use 'git merge' but with some I use
 'git cherry-pick'. However, cherry-picking leads to problems because a
 new commit ID is generated and I must remember which patches I have
 cherry-picked to my tree. Is there any easy way to tell which patches
 have and have not been applied?

    Thanks,
            Michal
-- 
		fuf		(fuf@mageo.cz)
