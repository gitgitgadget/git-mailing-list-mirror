From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] allow double click on current HEAD id after git-pull
Date: Thu, 09 Mar 2006 15:17:29 -0800
Message-ID: <7vy7zj2oom.fsf@assigned-by-dhcp.cox.net>
References: <20060211112630.GA12421@suse.de>
	<20060309210250.GY31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, Olaf Hering <olh@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 00:17:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHUNz-0005JI-Je
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 00:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbWCIXRc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 18:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbWCIXRc
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 18:17:32 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36313 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751949AbWCIXRb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 18:17:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309231441.DYTL17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 18:14:41 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060309210250.GY31278@pasky.or.cz> (Petr Baudis's message of
	"Thu, 9 Mar 2006 22:02:50 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17439>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Sat, Feb 11, 2006 at 12:26:30PM CET, I got a letter
> where Olaf Hering <olh@suse.de> said that...
>> Double click on to current HEAD commit id is not possible,
>> the dot has to go.
>> 
>> olaf@pomegranate:~/kernel/git/linux-2.6> git-pull
>> Unpacking 194 objects
>>  100% (194/194) done
>> * refs/heads/origin: fast forward to branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>> Updating from 5bc159e6cb7ca8d173195919ee935885c129011e to 25bf368b3d98668c5d5f38e2201d8bca16e52680.
>                                                                                                     ^
>
> Junio, is there any particular reason why this hasn't been applied?

Well I kind of like ending a sentence with a full stop.  Isn't
this something you can do by confuguiring your cut&paste?

But I do not have a _very_ strong feeling either way.  If
majority of the list wants it that way I do not mind.
