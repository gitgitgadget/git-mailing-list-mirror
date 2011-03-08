From: chrismarx <chrismarx@gmail.com>
Subject: Re: EGIT compare editor
Date: Tue, 8 Mar 2011 13:01:47 -0800 (PST)
Message-ID: <1299618107193-6142419.post@n2.nabble.com>
References: <48F4AA33.40605@oanda.com> <20081014150501.GD4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 22:01:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px42U-0005ka-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 22:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab1CHVBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 16:01:49 -0500
Received: from sam.nabble.com ([216.139.236.26]:59815 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756113Ab1CHVBs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 16:01:48 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <chrismarx@gmail.com>)
	id 1Px42N-0002Fg-6g
	for git@vger.kernel.org; Tue, 08 Mar 2011 13:01:47 -0800
In-Reply-To: <20081014150501.GD4856@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168692>

This thread is really high in google searches, and threw me off when I first
started using git. I think most people who are finding this thread are
probably wanting to know how to compare files with egit, or why they can't
see the compare functionality at all. 

If you're using egit, and your project is setup properly in eclipse, then
you should be able to just right-click and compare-with (head, etc). If you
don't see this option, perhaps you're project isn't actually being managed
by egit. check that the project name has something like [yourproject
master/branch] attached the tittle, and that under "Team" (right click on
project) you're seeing git options/commands. If not, try team-share and hook
up your project to the right repository. 

Official reference guide is here -
http://help.eclipse.org/helios/index.jsp?topic=/org.eclipse.egit.doc/help/EGit/User_Guide/Inspecting-the-state-of-the-Repository.html

--
View this message in context: http://git.661346.n2.nabble.com/EGIT-compare-editor-tp1332809p6142419.html
Sent from the git mailing list archive at Nabble.com.
