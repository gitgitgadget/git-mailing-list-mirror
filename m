From: Charles O'Farrell <charleso@charleso.org>
Subject: Re: How to sync changes in GIT to ClearCase or How to get the list of files changed in GIT for a specific branch
Date: Fri, 24 Apr 2009 12:10:58 +0000 (UTC)
Message-ID: <loom.20090424T120653-407@post.gmane.org>
References: <23197522.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 14:16:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxKKr-0001RS-Hg
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 14:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbZDXMPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 08:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753338AbZDXMPH
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 08:15:07 -0400
Received: from main.gmane.org ([80.91.229.2]:41164 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbZDXMPF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 08:15:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LxKJ4-0000ku-QE
	for git@vger.kernel.org; Fri, 24 Apr 2009 12:15:03 +0000
Received: from ppp118-208-25-197.lns2.bne1.internode.on.net ([118.208.25.197])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 12:15:02 +0000
Received: from charleso by ppp118-208-25-197.lns2.bne1.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 12:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 118.208.25.197 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.9) Gecko/2009040821 Firefox/3.0.9)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117429>

A Clearcase/Git bridge I wrote for my current job. It also pulls in history as
best it can.

http://github.com/charleso/git-cc/tree/master

Charles
