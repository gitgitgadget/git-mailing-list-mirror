From: Franck <vagabon.xyz@gmail.com>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 12:55:52 +0100
Message-ID: <cda58cb80511140355q1add0ba5n@mail.gmail.com>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
	 <437870AF.8060607@op5.se>
	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>
	 <43787831.3030404@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:56:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebcwv-0005A8-90
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 12:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbVKNLzy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 06:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVKNLzy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 06:55:54 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:26822 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751093AbVKNLzx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 06:55:53 -0500
Received: by zproxy.gmail.com with SMTP id 14so1245956nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 03:55:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gi+sH24A1YV3csyFWXhF9vzb5U3Kauh78MWHJRDbm4HZB7FPTVOHHRoNG5KLU0RtoUg6Q4MeR8ott6FwzSuCBpbNxkcwoGet32QViYoYk8gwc+CWeVgvji1WqUXzHxkcKX3IZevTU5CJMSk3tumVuvuYQEeSYJhj0mL+KqyKytc=
Received: by 10.36.247.5 with SMTP id u5mr4010309nzh;
        Mon, 14 Nov 2005 03:55:52 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 03:55:52 -0800 (PST)
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43787831.3030404@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11791>

2005/11/14, Andreas Ericsson <ae@op5.se>:
> Franck wrote:
> > Hi Andrea
>
> Not sure why, but 85% of all people replying to me by email refer to me
> as "Andrea". Sort of cute I suppose, although I'm somewhat lacking in
> the TnA department.

oops, sorry Andreas for that ! I use to spelling this name without 's'
that's why I did the mistake I think.

> This seems to imply you're running git-rev-list as root. The default
> installation directory for git is $HOME/bin which might not necessarily
> be in the $PATH once "wish" and friends have had their say.

nope every commands I'm running are not run as root. $HOME/bin is in my path.

> > nope I just did: "make; make install". I tried what you suggested but
> > it's still failing the same way...
>
> So your binaries are installed in $HOME/bin then?

yes.

> Are you running all commands as the same user?
>

yes

> You could try installing from RPM. It should work nicely for all users.

well, I would prefer to use gt repository instead since GIT is in
active developpement.

Thanks
--
               Franck
