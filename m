From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Fri, 18 Jul 2008 00:32:53 +0200
Message-ID: <200807180032.53642.robin.rosenberg.lists@dewire.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <6B9BBA72-6E75-47E3-911A-4A5309090807@sb.org> <85wsjkgr7a.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 00:39:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJc7y-0002XR-KT
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 00:39:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbYGQWiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 18:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYGQWiL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 18:38:11 -0400
Received: from av6-2-sn3.vrr.skanova.net ([81.228.9.180]:38991 "EHLO
	av6-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYGQWiK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 18:38:10 -0400
Received: by av6-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 71D623A83B; Fri, 18 Jul 2008 00:38:07 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av6-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 0A773392B0; Fri, 18 Jul 2008 00:38:07 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id BE9EA37E42;
	Fri, 18 Jul 2008 00:38:06 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <85wsjkgr7a.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88935>

torsdagen den 17 juli 2008 23.02.01 skrev David Kastrup:
> Kevin Ballard <kevin@sb.org> writes:
> 
> > On Jul 17, 2008, at 9:05 AM, David Kastrup wrote:
[...]
> > issue a command to copy by URL, then issue an `svn switch` command,
> > and then I have to remember that I have a switched repository.
> 
> Huh?  How is that different to remembering a switched branch?  Anyway,
That's what we have the custom prompt in contrib for. Like this.
[me@mymachine EGIT (rr/gitselectionprovider)]$

Obviously it's not mandatory, but I recommend it as it also show stuff like
rebase, am, merge and bisect status too.

Maybe one you do that for SVN too. I have one for CVS.

> one tends to check out different branches in different workdirs.
This is very different for individuals. 

-- robin
