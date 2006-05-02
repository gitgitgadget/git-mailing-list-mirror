From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-mkpatch use case
Date: Wed, 3 May 2006 00:34:38 +0200
Message-ID: <20060502223438.GH27631@pasky.or.cz>
References: <44570E8E.5070402@itaapy.com> <20060502215703.GK27689@pasky.or.cz> <46a038f90605021519x5ee680b0v78dd5c092e1b191f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Belmar-Letelier <luis@itaapy.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 00:33:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb3RA-0000II-Ju
	for gcvg-git@gmane.org; Wed, 03 May 2006 00:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWEBWdm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 18:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWEBWdl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 18:33:41 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42421 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965028AbWEBWdl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 18:33:41 -0400
Received: (qmail 13709 invoked by uid 2001); 3 May 2006 00:34:38 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90605021519x5ee680b0v78dd5c092e1b191f@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19434>

Dear diary, on Wed, May 03, 2006 at 12:19:00AM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> On 5/3/06, Petr Baudis <pasky@suse.cz> wrote:
> >not many people actually use it nowadays, I believe. You can apply it
> >back using cg-patch (or even patch itself, or git-apply if you are
> >lucky), but it won't automagically extract the commit message and
> >authorship information.
> 
> Erm... I don't personally use it, but cg-patch --long-help tells me...
> 
> -c::
>        Automatically extract the commit message and authorship information
>        (if provided) from the patch and commit it after applying it
>        successfuly.
> 
> Truth in advertising? ;-)

Uhm, no, it just didn't stick in my mind in the storm of cg-patch
improvements. :-) Oops.

So, YES, there IS a way to apply cg-mkpatches preserving autorship and
everything - cg-patch -c. Sorry for the confusion. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
