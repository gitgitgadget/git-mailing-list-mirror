From: Graeme Geldenhuys <graemeg@gmail.com>
Subject: git svn graft-branches
Date: Fri, 17 Jul 2009 13:25:42 +0200
Message-ID: <h3pn45$eam$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 13:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRlZz-00009A-Hd
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 13:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934443AbZGQL0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 07:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934419AbZGQL0L
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 07:26:11 -0400
Received: from main.gmane.org ([80.91.229.2]:60189 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934411AbZGQL0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 07:26:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MRlZp-0003XN-7h
	for git@vger.kernel.org; Fri, 17 Jul 2009 11:26:09 +0000
Received: from 41.177.101.200 ([41.177.101.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 11:26:09 +0000
Received: from graemeg by 41.177.101.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 11:26:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 41.177.101.200
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123460>

Hi,

Looking at the history of a cloned SubVersion repository, I noticed that 
git does track svn merges between the subversion branches.

Apparently there was a command to help git detect this merge:

   git-svn graft-branches

As documented in the URL below

http://www.kernel.org/pub/software/scm/git/docs/v1.5.0.7/git-svn.html


Now I have git version 1.6.3.3.363.g725cf7 but if I run the following, 
git simply shows the help, and graft-branches doesn't seem to be a 
command anymore. Was 'graft-branches' removed from Git?

  $ git svn graft-branches

Above does not work anymore.


Regards,
   - Graeme -

-- 
fpGUI Toolkit - a cross-platform GUI toolkit using Free Pascal
http://opensoft.homeip.net/fpgui/
