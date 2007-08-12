From: David Kastrup <dak@gnu.org>
Subject: Re: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 23:35:56 +0200
Message-ID: <85y7gg5tc3.fsf@lola.goethe.zz>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	<85abswo9gf.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
	<85wsw0mt77.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708121255230.30176@woody.linux-foundation.org>
	<69b0c0350708121358w13d04047s1916d3599c2e040a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Govind Salinas" <govindsalinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 23:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKL6R-00019i-IU
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 23:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760890AbXHLVf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 17:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759786AbXHLVf7
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 17:35:59 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:52065 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759481AbXHLVf6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 17:35:58 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id F0D804CB2E;
	Sun, 12 Aug 2007 23:35:56 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id DD2C15BD69;
	Sun, 12 Aug 2007 23:35:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id AC8B48C467;
	Sun, 12 Aug 2007 23:35:56 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 485061C3C79D; Sun, 12 Aug 2007 23:35:56 +0200 (CEST)
In-Reply-To: <69b0c0350708121358w13d04047s1916d3599c2e040a@mail.gmail.com> (Govind Salinas's message of "Sun\, 12 Aug 2007 15\:58\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3936/Sun Aug 12 17:10:09 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55727>

"Govind Salinas" <govindsalinas@gmail.com> writes:

> Since you all are talking about such things, I thought I would show
> you a shot of my git UI.  It does what I think Linus is talking
> about.  I have a window of x commits which I show in a list and
> allow the user to look at each one.  You can click on a commit to
> see full details.  There are back/next buttons to browse the entire
> history and date/author/etc filters to narrow your results.  The
> only thing I am missing is the pretty chart that gitk and others
> have.  The chart (in my app) would only show the chart for the
> current window of commits.  I'll get to that sometime after work
> gives me enough time to start working on this again.
>
> Is this something like what you had in mind?

Well, what I have in mind boils down to something I can use without
leaving my editor...  Your tool does not look all too different from
gitk, git-gui, giggle, giwhatever.  There is a variety of those
around, and they all don't really blow me away.  Part of the problem
is that my work flow involves editing a lot and I naturally use Emacs.
If those tools used Emacs for all their editing, I'd probably become
more friendly with them (for what it's worth: one can talk with Emacs
through sockets if necessary).  However, Linus might have something
different in mind.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
