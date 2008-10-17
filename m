From: Eric Raible <raible@gmail.com>
Subject: Re: Excluding files from git-diff
Date: Fri, 17 Oct 2008 17:33:43 +0000 (UTC)
Message-ID: <loom.20081017T173145-53@post.gmane.org>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net> <48F8BDA7.50901@pflanze.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 19:35:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqtEB-0006ky-Ai
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 19:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbYJQRdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 13:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbYJQRdx
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 13:33:53 -0400
Received: from main.gmane.org ([80.91.229.2]:46087 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755174AbYJQRdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 13:33:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KqtCw-0003OG-Nw
	for git@vger.kernel.org; Fri, 17 Oct 2008 17:33:51 +0000
Received: from adsl-75-24-208-45.dsl.pltn13.sbcglobal.net ([75.24.208.45])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 17:33:50 +0000
Received: from raible by adsl-75-24-208-45.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 17:33:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.208.45 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.30 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98488>

Christian Jaeger <christian <at> pflanze.mine.nu> writes:

> 
> Michael J Gruber wrote:
> > Or put it
> > in .git/info/excludes.
> 
> Only "git ls-files --others --exclude-from=.git/info/exclude" will exclude

Could it be a simple as "excludes" vs "exclude"?

- Eric
