From: Mark Burton <markb@ordern.com>
Subject: Question: How to list files that haven't been modified?
Date: Sat, 4 Oct 2008 20:07:33 +0000 (UTC)
Message-ID: <loom.20081004T195935-879@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 04 22:21:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmDcs-0003cm-A5
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbYJDUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbYJDUUG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 16:20:06 -0400
Received: from main.gmane.org ([80.91.229.2]:45353 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752669AbYJDUUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 16:20:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KmDbf-0005xR-0o
	for git@vger.kernel.org; Sat, 04 Oct 2008 20:20:03 +0000
Received: from host86-128-74-78.range86-128.btcentralplus.com ([86.128.74.78])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 20:20:03 +0000
Received: from markb by host86-128-74-78.range86-128.btcentralplus.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 20:20:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 86.128.74.78 (Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.0.3) Gecko/2008092510 Ubuntu/8.04 (hardy) Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97476>


Hi,

It's still early days for me and I haven't yet discovered how to ask git to list
all the files in a tree that don't have pending modifications (staged or not). I
have read about ls-files but it doesn't seem to offer that option. As far as I
can tell, it can list the files known to git and the files that have been
modified but not the difference between those sets.

Thanks,

Mark
