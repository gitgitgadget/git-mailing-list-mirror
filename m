From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 15:55:05 -0700 (PDT)
Message-ID: <20060928225505.23517.qmail@web51003.mail.yahoo.com>
References: <Pine.LNX.4.63.0609290032440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 00:55:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT4mv-0002kD-5Q
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 00:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161365AbWI1WzJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161368AbWI1WzI
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 18:55:08 -0400
Received: from web51003.mail.yahoo.com ([206.190.38.134]:47221 "HELO
	web51003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1161369AbWI1WzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 18:55:07 -0400
Received: (qmail 23519 invoked by uid 60001); 28 Sep 2006 22:55:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=e05XPH4Eonva+JRQecI92OJDyXdS5uPeebvIqz5YFTUY0Rko+Ot4EMS8QCCB8GC9veVpMbWmj++s94DQNwft91fM7lRu2FXxK1pdcHHi/ttQAQ8sOPJkM8gmBtLum/uxxrrXWtIkAAYJZdC/gm28cboBjcD89C9GutGJt8c4ecA=  ;
Received: from [207.172.80.85] by web51003.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 15:55:05 PDT
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609290032440.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28064>

--- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> what exactly are you trying to achieve here? 

Timestamps not being all over the place in gitweb.cgi. 

> If you really want to understand why git does not rely on timestamps, and 
> why it should not, and why you can still be happy nevertheless, there are 
> enough answers in this thread.

I agree and understand that distributed git should not and does not rely on timestamps, I am just
suggesting that it might be worthwhile to _locally_ track local commit time more efficiently for
local use in things like gitweb.cgi. 

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
