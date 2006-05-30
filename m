From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 13:03:06 -0400
Message-ID: <20060530170306.GA10895@trixie.casa.cgf.cx>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net> <7v1wuc3t9y.fsf@assigned-by-dhcp.cox.net> <7vu0782e33.fsf@assigned-by-dhcp.cox.net> <81b0412b0605300623h4f915829yb388c8fdc062c009@mail.gmail.com> <20060530152103.GB8931@trixie.casa.cgf.cx> <81b0412b0605300900l7530792dqcea6d812602b9176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 30 19:03:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl7cp-0002lM-TC
	for gcvg-git@gmane.org; Tue, 30 May 2006 19:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWE3RDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 13:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWE3RDI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 13:03:08 -0400
Received: from pool-71-248-179-19.bstnma.fios.verizon.net ([71.248.179.19]:64642
	"EHLO cgf.cx") by vger.kernel.org with ESMTP id S932336AbWE3RDG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 13:03:06 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 0B49D13C01F; Tue, 30 May 2006 13:03:06 -0400 (EDT)
To: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0605300900l7530792dqcea6d812602b9176@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21037>

On Tue, May 30, 2006 at 06:00:20PM +0200, Alex Riesen wrote:
>On 5/30/06, Christopher Faylor <me@cgf.cx> wrote:
>>>froze afterwards anyway, as "wc" or "perl" did. Besides, it the
>>>command often freezes that poor imitation of xterm windows has.
>>
>>I assume that "the poor imitation of xterm" is referring to cygwin's
>>xterm here.  It's really too bad that you can't get into the mindset of
>>reporting problems to the cygwin mailing list when you notice them.
>
>Actually, I was referring to windows console. And no, I don't think you
>could do something about it.
>
>But honestly, I don't think it's worth supporting windows in general
>and cygwin in particular. And before anyone (again) asks why am
>_I_ doing it: I'd have to do my job with Perforce otherwise (as if
>windows wasn't bad enough...)

I think you've made your opinion on this issue pretty clear.

>>I can't comment on the proposed patch since, AFAIK, using cat, wc, and
>>(cygwin's) perl should all work just fine but I don't think it is ever
>>correct to complain about a platform in released software.
>
>If you actually read the message, you'd probably notice ActiveState Perl.

I actually did read the message.  Do you really want to employ this type
of hackneyed usenet technique here?

Referring to the Windows console as "xterm" (if that is what you were
actually doing) means that your bug report and patch were unclear.

You were also talking about "cat" and "wc" hanging.  Neither is a
Windows command.  Since you've previously complained that you had
to use Cygwin, I think it is safe to assume that you were talking
about Cygwin commands.

>I have no idea why have you taken my post as an attempt to insult cygwin;

There you go.  Kick it up a notch.  I asked you (and have been asking
you) to report problems with Cygwin in the Cygwin forums.  I don't think
that someone mentioning that software has bugs is an "insult".  You
obviously aren't insulting git by fixing bugs that you find.

>IF I had that in mind I'd dedicate a whole long post just to that.

I could write a really long essay about inappropriate mailing list
hostility, too.  Neither would be on-topic here, of course.

Anyway, I think that comments should be factual and not contain negative
opinions about Windows, Solaris, or whatever.

cgf
