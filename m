From: Eric Raible <raible+git@gmail.com>
Subject: Re: [RFC] Colorization of log --graph
Date: Wed, 18 Mar 2009 16:52:42 +0000 (UTC)
Message-ID: <loom.20090318T164728-444@post.gmane.org>
References: <20090318100512.GA7932@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 17:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljz2A-0006A9-0G
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 17:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755018AbZCRQw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 12:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbZCRQw5
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 12:52:57 -0400
Received: from main.gmane.org ([80.91.229.2]:56641 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbZCRQw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 12:52:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ljz0f-0005kj-7v
	for git@vger.kernel.org; Wed, 18 Mar 2009 16:52:54 +0000
Received: from adsl-75-24-106-84.dsl.pltn13.sbcglobal.net ([75.24.106.84])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 16:52:53 +0000
Received: from raible+git by adsl-75-24-106-84.dsl.pltn13.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 16:52:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 75.24.106.84 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113629>

Allan Caffee <allan.caffee <at> gmail.com> writes:

> 
> I know that _some_ people arn't particularly fond of colors, but I was
> wondering how difficult it would be to colorize the edges on the
> --graph drawn by the log command?  It can be a little tricky trying to
> follow them with a relatively complex history.  I was thinking something
> like gitk already does.  Is anybody else interested in seeing this?
> 
> ~Allan

This may be clueless (I suspect that it is) but I have never understood
the meaning of the different line colors in gitk.  They seems arbitrary to me.

I get that the current HEAD is represented as a yellow dot, but that's it.
(As an aside, it might be nice if merges had a different color dot than
normal commits).

Can anyone clue me in?

- Eric
