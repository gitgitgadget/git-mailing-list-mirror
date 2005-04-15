From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 12:30:05 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504151227590.27637@cag.csail.mit.edu>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
 <1113556448.12012.269.camel@baythorne.infradead.org>
 <Pine.LNX.4.58.0504150740310.7211@ppc970.osdl.org> <20050415085424.5f61b80b.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, dwmw2@infradead.org,
	junkio@cox.net, pasky@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 18:28:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMTf4-0005rE-7b
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 18:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbVDOQaq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVDOQaq
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 12:30:46 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:24490 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261857AbVDOQam (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 12:30:42 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMThu-0006kW-00; Fri, 15 Apr 2005 12:30:14 -0400
To: Paul Jackson <pj@engr.sgi.com>
In-Reply-To: <20050415085424.5f61b80b.pj@engr.sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 15 Apr 2005, Paul Jackson wrote:

> Um ah ... could you explain what you mean by inter and intra file diffs?

intra file diffs: here are two versions of the same file.  what changed? 
inter file diffs: here is a new file, and here are *all the files in the 
current committed version*.  Where did the contents of this new file come 
from?  (Note that the new file is often a slightly changed version of an 
existing file in the current committed version.  But we don't assume that 
must be true.)
  --scott

supercomputer Pakistan WSHOOFS SECANT LCPANGS SDI assassination ZPSECANT 
SEQUIN AEBARMAN ESCOBILLA bomb mustard STANDEL ESGAIN Nazi FJDEFLECT
                          ( http://cscott.net/ )
