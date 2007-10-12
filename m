From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Sat, 13 Oct 2007 01:36:54 +0200
Message-ID: <20071012233654.GX31659@planck.djpig.de>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 13 01:45:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgU4G-0003KA-On
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 01:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbXJLXhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 19:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbXJLXhK
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 19:37:10 -0400
Received: from planck.djpig.de ([85.10.192.180]:2843 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757337AbXJLXhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 19:37:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 6205C88231;
	Sat, 13 Oct 2007 01:37:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XROdlk+arBuS; Sat, 13 Oct 2007 01:36:55 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 0B44A88232; Sat, 13 Oct 2007 01:36:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <8fe92b430710121508g13917080mac156250abfccf20@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60709>

On Sat, Oct 13, 2007 at 12:08:18AM +0200, Jakub Narebski wrote:
>  * I think that it is very nice that git is in the native OS
>    repositories for Fedora. The Debian version needs updating.
> 
>    (git Makefile has rpm target, and git.spec target; perhaps this is
>    the cause)

Nah, the Debian problem is just bad timing. Debian stable is stuck with
1.4.4 which is unfortunate but not fixable. unstable is very fast with
updates and backports.org is very good, too (but lacks at least 10 days
due to upload policy).

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
