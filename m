From: Eric Raible <raible@gmail.com>
Subject: Re: Problems with GIT under Windows - "not uptodate"
Date: Tue, 1 Sep 2009 16:52:45 +0000 (UTC)
Message-ID: <loom.20090901T184650-434@post.gmane.org>
References: <a21e6af7ee05f56fd8c02d0955af1c72.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 18:53:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiWbl-0008GM-EX
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 18:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbZIAQxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 12:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbZIAQxG
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 12:53:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:42543 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbZIAQxF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 12:53:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MiWbS-0008BH-O2
	for git@vger.kernel.org; Tue, 01 Sep 2009 18:53:06 +0200
Received: from c-98-234-56-232.hsd1.ca.comcast.net ([98.234.56.232])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 18:53:06 +0200
Received: from raible by c-98-234-56-232.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 18:53:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 98.234.56.232 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.39 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127545>

 <david.hagood <at> gmail.com> writes:

> Error: Entry "Some file name" not uptodate: cannot merge.
> 
> We've tried "git reset --hard; git pull ." We've tried "git reset --hard;
> git checkout -f master". Neither seems to fix this.

http://article.gmane.org/gmane.comp.version-control.git/122862
