From: Pavel Roskin <proski@gnu.org>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 23:55:55 -0400
Message-ID: <1154145355.26378.35.camel@dv>
References: <20060728063620.GD30783@spearce.org>
	 <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx>
	 <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net>
	 <20060729033214.GA28128@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 29 05:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6fvs-00029C-TN
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 05:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161432AbWG2D4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 23:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbWG2D4F
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 23:56:05 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:39087 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161432AbWG2D4E
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 23:56:04 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1G6fvm-0000CP-Ls
	for git@vger.kernel.org; Fri, 28 Jul 2006 23:56:02 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1G6fvf-0004Ms-Qb; Fri, 28 Jul 2006 23:55:55 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060729033214.GA28128@spearce.org>
X-Mailer: Evolution 2.7.4 (2.7.4-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24411>

On Fri, 2006-07-28 at 23:32 -0400, Shawn Pearce wrote:

> Hmm.  My website is known to return 200 OK status codes on missing
> files with HTML pages rather than proper 404 Not Found.  I guess
> I need to get that fixed.

Maybe git-http-fetch could treat MIME type text/html like error 404?
It's not like any valid file git requests can be in HTML format.

> I just compiled and installed `next` (1.4.2.rc1.g802da) and it can
> clone this repository just fine over HTTP, despite my broken server.
> So I'm not really sure what is going on.

Sorry, I was unclear.  I can clone the repository, I was just concerned
that something was missing from it.

-- 
Regards,
Pavel Roskin
