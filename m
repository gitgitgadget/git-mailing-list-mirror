From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: correct git merge behavior or corner case?
Date: Sun, 19 Apr 2009 20:19:16 -0700
Message-ID: <20090420031916.GV23604@spearce.org>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 05:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvk3v-00012g-Q3
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 05:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbZDTDTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 23:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZDTDTR
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 23:19:17 -0400
Received: from george.spearce.org ([209.20.77.23]:60459 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbZDTDTR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 23:19:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AC92D38211; Mon, 20 Apr 2009 03:19:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116930>

Tuncer Ayaz <tuncer.ayaz@gmail.com> wrote:
> I have stumbled upon the following blog post via one of
> the news aggegrators and wondered whether the behavior
> is correct and expected or he's expecting something wrong
> or doing something wrong.
> 
> I cannot see a wrong usage pattern from what he has written.
> 
> http://blog.teksol.info/2009/04/15/beware-of-gits-content-tracking.html
> 
> as the author hasn't posted here after a couple of days
> I decided to take his question here for at least understanding
> what behavior he is experiencing.

Well, the author of the blog post gave us *no* information about
what he did, or what he expected.  He's just showing us a diff,
which we're not even sure how he created, and then complaining
about Git not doing something he wanted.

-- 
Shawn.
