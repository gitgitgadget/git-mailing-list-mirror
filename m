From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking CVS
Date: Thu, 22 Jun 2006 10:43:42 -0700
Message-ID: <7virmtozld.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606220541y15d66fa6t33ab0c80ae05f764@mail.gmail.com>
	<20060622135831.GB21864@pasky.or.cz>
	<7vveqtp1dl.fsf@assigned-by-dhcp.cox.net> <e7ej5o$1p6$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 19:44:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtTDc-0006mi-Ac
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 19:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWFVRnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 13:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWFVRno
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 13:43:44 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:53998 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932598AbWFVRno (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 13:43:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622174343.NTJQ11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 13:43:43 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e7ej5o$1p6$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	22 Jun 2006 19:14:33 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22350>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Petr Baudis <pasky@suse.cz> writes:
>  
>>> Perhaps we might make a special command which would sync the index set
>>> with the working copy set...
>> 
>> I think that makes sense.  Something like what "git-commit -a"
>> does before making a commit.
>
> Isn't that what "git update-index --again" does? 

No.
