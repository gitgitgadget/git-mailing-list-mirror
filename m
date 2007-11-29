From: Al Boldi <a1426z@gawab.com>
Subject: Re: git guidance
Date: Thu, 29 Nov 2007 08:27:04 +0300
Message-ID: <200711290827.04950.a1426z@gawab.com>
References: <20071127235237.GF15227@1wt.eu> <Pine.LNX.4.64.0711281811500.27959@racer.site> <200711282130.12864.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 29 06:28:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxbwO-0006hl-Bz
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 06:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbXK2F1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 00:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbXK2F1j
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 00:27:39 -0500
Received: from [212.12.190.53] ([212.12.190.53]:33766 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750857AbXK2F1i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 00:27:38 -0500
Received: from localhost ([10.0.0.111])
	by raad.intranet (8.8.7/8.8.7) with ESMTP id IAA13125;
	Thu, 29 Nov 2007 08:27:15 +0300
User-Agent: KMail/1.5
In-Reply-To: <200711282130.12864.a1426z@gawab.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66504>

Jakub Narebski wrote:
> Al Boldi wrote:
> > Johannes Schindelin wrote:
> >> By that definition, no SCM, not even CVS, is transparent.  Nothing
> >> short of unpacked directories of all versions (wasting a lot of disk
> >> space) would.
> >
> > Who said anything about unpacking?
> >
> > I'm talking about GIT transparently serving a Virtual Version Control
> > dir to be mounted on the client.
>
> Are you talking about something like (in alpha IIRC) gitfs?
>
>   http://www.sfgoth.com/~mitch/linux/gitfs/

This looks like a good start.

> Besides, you can always use "git show <revision>:<file>". For example
> gitweb (and I think other web interfaces) can show any version of a file
> or a directory, accessing only repository.

Sure, browsing is the easy part, but Version Control starts when things 
become writable.


Thanks for the link!

--
Al
