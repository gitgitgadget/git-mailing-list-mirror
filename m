From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] Git wiki
Date: Fri, 5 May 2006 20:20:01 +0200
Message-ID: <20060505182001.GC27689@pasky.or.cz>
References: <20060505005659.9092.qmail@science.horizon.com> <20060505181540.GB27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 20:19:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fc4tK-0000xd-IB
	for gcvg-git@gmane.org; Fri, 05 May 2006 20:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWEESSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 14:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWEESSv
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 14:18:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2030 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751202AbWEESSu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 May 2006 14:18:50 -0400
Received: (qmail 13427 invoked by uid 2001); 5 May 2006 20:20:01 +0200
To: linux@horizon.com
Content-Disposition: inline
In-Reply-To: <20060505181540.GB27689@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19622>

Dear diary, on Fri, May 05, 2006 at 08:15:41PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> There are really two distinctions here which should be kept separate:
> automatic vs. explicit movement tracking and file-level vs.
> subfile-level movement tracking.

I should have revised this paragraph before sending the mail out, I
ended up sorting out my thoughts on the subject as I wrote the mail. The
two aspects end up so tied that it makes sense to mingle them. Examining
them separately here still hopefully shed some light on possible
reasoning behind the Git design decisions.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
