From: Joshua Haberman <joshua@reverberate.org>
Subject: Re: visualizing Git's Git repo
Date: Mon, 26 May 2008 23:42:24 +0000 (UTC)
Message-ID: <loom.20080526T233903-825@post.gmane.org>
References: <CA563F5A-5E12-42F7-BDFD-04FE3A882028@reverberate.org> <87ve104qoz.fsf@offby1.atm01.sea.blarg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 01:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0mOc-00075F-6Z
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbYEZXpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbYEZXpj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:45:39 -0400
Received: from main.gmane.org ([80.91.229.2]:59310 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879AbYEZXpI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:45:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K0mNC-0000p3-Ny
	for git@vger.kernel.org; Mon, 26 May 2008 23:45:02 +0000
Received: from c-24-19-134-23.hsd1.mn.comcast.net ([24.19.134.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 23:45:02 +0000
Received: from joshua by c-24-19-134-23.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 23:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.19.134.23 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9) Gecko/2008051202 Firefox/3.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82976>

Eric Hanchrow <offby1 <at> blarg.net> writes:
> 
> You might not know -- I didn't until five minutes ago -- that you can
> omit entire branches, like this:
> 
>         $ gitk --all  ^refs/remotes/origin/man ^refs/remotes/origin/html

Thanks for the tip -- I had tried the converse, which is to only include master,
but both this and your strategy still leave at least 10 concurrent branches at
almost any point in time.

Josh
