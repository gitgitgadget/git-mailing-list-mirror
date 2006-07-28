From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 08:49:59 +0200
Message-ID: <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx>
References: <20060728063620.GD30783@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 08:50:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6MBE-0001rL-UT
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 08:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWG1Gu3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 02:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWG1Gu3
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 02:50:29 -0400
Received: from main.gmane.org ([80.91.229.2]:35037 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751130AbWG1Gu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 02:50:28 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G6MAp-0001mO-9m
	for git@vger.kernel.org; Fri, 28 Jul 2006 08:50:15 +0200
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 08:50:15 +0200
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 08:50:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24370>

On 2006-07-28, Shawn Pearce <spearce@spearce.org> wrote:
> My Java GIT library and Eclipse GIT team provider is now at a point
> where it may be partially useful to someone else who is also trying
> to write something which interacts with GIT.  Or who might also
> be interested in seeing a pure-Java Eclipse team provider for GIT.
>
> So I've posted my repository (currently ~200 KB) on my website:
>
>   http://www.spearce.org/projects/scm/egit.git
>

Doesn't work for me.

devil:~/src git clone http://www.spearce.org/projects/scm/egit.git
error: File ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2 (http://www.spearce.org/projects/scm/egit.git/objects/ac/32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2) corrupt
Getting pack list for http://www.spearce.org/projects/scm/egit.git/
Getting alternates list for http://www.spearce.org/projects/scm/egit.git/
Also look at <html xmlns="http://www.w3.org/1999/
Also look at    <title>Insufficiently Random: The lonely musings of a loosely connected software developer.<
Also look at            @import url( http://www.spearce.org/wordpress/wp-content/themes/ir-classic/style
Also look at    <link rel="pingback" href="http://www.spearce.org/wordpress/xmlrpc.
Also look at            <link rel='archives' title='April 2006' href='http://www.spearce.org/2006/
Also look at    <link rel='archives' title='February 2006' href='http://www.spearce.org/2006/
[...]
Also look at <li><a href="feed:http://www.spearce.org/comments/feed/" title="The latest comments to all posts in RSS">Comments <abbr title="Really Simple Syndication">RSS</abbr></
*** glibc detected *** double free or corruption (!prev): 0x080933b0 ***
/usr/bin/git-clone: line 29: 10712 Aborted                 git-http-fetch -v -a -w "$tname" "$name" "$1/"

-Peter
