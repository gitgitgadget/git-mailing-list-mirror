From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Fri, 2 Jun 2006 00:00:37 -0400
Message-ID: <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 06:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm0q1-0001Ep-2y
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 06:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWFBEAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 00:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWFBEAi
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 00:00:38 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:49026 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751261AbWFBEAh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 00:00:37 -0400
Received: by nz-out-0102.google.com with SMTP id s18so441640nze
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 21:00:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pNXUXkmOMY65KgSZbNvMhyJFD4d/eolokiE7EoRY4dHuMXzhvbEi9YDRvyV4OZI8kjsEJK8EBuppyrvTWeHaGEjZXSOhB6EnzwGJ6dgtU00XEG+r0sLiTlub5PxE29OqcnVSoRUH45165c7JYGM1ePtjbsS9nXNHkyp3jMRmfAk=
Received: by 10.36.127.15 with SMTP id z15mr1817289nzc;
        Thu, 01 Jun 2006 21:00:37 -0700 (PDT)
Received: by 10.36.39.3 with HTTP; Thu, 1 Jun 2006 21:00:37 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1149220518.5521.43.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21141>

On 6/1/06, Keith Packard <keithp@keithp.com> wrote:
> On Thu, 2006-06-01 at 23:47 -0400, Jon Smirl wrote:
> > On 6/1/06, Keith Packard <keithp@keithp.com> wrote:
> > > Git runs fine on Windows these days; asking people to use reasonable
> > > tools to contribute to the project doesn't seem crazy to me.
> >
> > WIndows, Mac, Solaris and Linux will cover most Firefox developers.
> > Is git to go on those platforms? Is WIndows native or cygwin?
>
> I think the windows stuff may still be cygwin, but Mac and Solaris work
> fine with the git, of course. It's just simple posix code, after all

It is going to have to be native Windows to move some of the
developers over. They are true blue MS types that won't touch anything
close to Unix so cygwin is out.

-- 
Jon Smirl
jonsmirl@gmail.com
