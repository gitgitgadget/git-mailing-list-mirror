From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: windows problems summary
Date: Thu, 2 Mar 2006 16:57:42 +0100
Message-ID: <4fb292fa0603020757q4cd3e80cjbb63d0dc58d19756@mail.gmail.com>
References: <81b0412b0603020649u99a2035i3b8adde8ddce9410@mail.gmail.com>
	 <20060302152329.GH2781@trixie.casa.cgf.cx>
	 <81b0412b0603020735j603b3518ob5e27a02c531093a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Christopher Faylor" <me@cgf.cx>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 16:58:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEqBX-0001nO-Qj
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 16:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWCBP5p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 10:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751038AbWCBP5p
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 10:57:45 -0500
Received: from nproxy.gmail.com ([64.233.182.206]:51149 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750729AbWCBP5o convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 10:57:44 -0500
Received: by nproxy.gmail.com with SMTP id l37so312474nfc
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 07:57:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iLJjN4WWUEZq5MuEQIiiYxGOaPMsWDckYXld2hjVjkQ0kAaclPleeE0zWpGRJEYOc1pFVBFa9mfeQ9KP/sLfHgLGrQj/7hLvkliYBl2UKIr8dbVz8LoihYxIKQ/T22fiW07HgBMMPUf+VPr8LgrTuG9VrNN2b3Np6kS6fEvo5HI=
Received: by 10.48.142.1 with SMTP id p1mr726389nfd;
        Thu, 02 Mar 2006 07:57:42 -0800 (PST)
Received: by 10.49.2.17 with HTTP; Thu, 2 Mar 2006 07:57:42 -0800 (PST)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0603020735j603b3518ob5e27a02c531093a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17084>

On 3/2/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 3/2/06, Christopher Faylor <me@cgf.cx> wrote:
> >
> > Are we *really* contemplating porting git to native Windows?
> >
>
> Actually, I wasn't thinking about that when I was writing that mail,
> but ... why not?
> Cygwin makes syscalls many times slower, git is very slow on
> windows, users (well, I) want it faster, so if the needed api subset
> can be narrowed down to a reasonable amount of work - I think
> I'd give the idea a try.

Is the goal to have something like a git-turtoise (as {svn,cvs}-turtoise) ?
I personaly think that is could be benefic.

--
Beber
#e.fr@freenode
