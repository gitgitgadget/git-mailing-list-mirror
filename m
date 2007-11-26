From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Screencast ?
Date: Mon, 26 Nov 2007 13:33:16 -0800
Message-ID: <d411cc4a0711261333p4c99f447k81c3833cd679e551@mail.gmail.com>
References: <fi1a9f$30q$1@ger.gmane.org> <86bq9n4469.fsf@blue.stonehenge.com>
	 <d411cc4a0711211603o525a25c4i3e04d0319e68204f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 22:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwlaD-00087X-OU
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 22:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbXKZVdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 16:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753304AbXKZVdS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 16:33:18 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:13363 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbXKZVdS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 16:33:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so958405wah
        for <git@vger.kernel.org>; Mon, 26 Nov 2007 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rb+1EYoqEQtjwu9otlB9f5yqe63owm3vJ7wESUEL1r0=;
        b=cfwUyUa3s93PtVhJU9oWakWxMNE42L+x1V+VnumRIdYCa5IslK6nMz/aycOJsq5fOYFFaW/IhfTVWD2PEKqdyg6ucUZns/WBQ8GSD5kRPmcgsQpzleVQIRo5MZDM2k6WaSrkZBaNKdDWLaog3AtLyOzxWX7U34RWgTVkQ1oeJo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tNpQyfguiPsxdz+yAgrrjt2bt0o0whTbDzAGOUMhUxlW4rXH2wxfIigqWf/DgtKiQ3HfzopU5cPz9ASALA3mvofBC1GCmDvUEwH5VJDSq50khSmWhd02BOnuPxZ16jxWyOKrzioR2UQP5EBGAtFdPmP4WZ3Zwc7Dn7+t3fjGnjA=
Received: by 10.114.53.1 with SMTP id b1mr604900waa.1196112797069;
        Mon, 26 Nov 2007 13:33:17 -0800 (PST)
Received: by 10.114.14.14 with HTTP; Mon, 26 Nov 2007 13:33:16 -0800 (PST)
In-Reply-To: <d411cc4a0711211603o525a25c4i3e04d0319e68204f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66130>

I've created a screencast on using Git to manage and deploy Rails
applications.  It's not purely about Git - goes into some Rails and
Capistrano usage, but there is a good amount of practical git workflow
- pushing, pulling, branching, etc.  It's free, too.  You can
watch/download it here:

http://jointheconversation.org/railsgit

Also, if you're in the Bay Area, we're hosting a Peepcode and Pizza
party on Git - where we'll show that git peepcode episode and have
some git related presentations.  You're welcome to come to that to
learn whatever you need, if you can.

http://ruby.meetup.com/123

Lastly, if you're a rubyist, I've written pretty comprehensive ruby
bindings to git that might be helpful because it's a bit more object
oriented approach to using git - the examples might help.

http://jointheconversation.org/rubygit

I'm also working on a new screencast on Git that's more visual
(example-wise) than most of the stuff I've seen, so I'll be happy to
email that to you when it's done.

Let me know if any of that is helpful.


> On Nov 21, 2007 2:36 PM, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>
> > >>>>> "Michael" == Michael Donaghy <mike@mikedonaghy.org> writes:
> >
> > Michael> I am a new user of git and SCMs in general , I have learned a lot
> > Michael> from the docs , irc and just using it , but there are just some
> > Michael> concepts that hare hard to grasp , I am a very visual persion
> > Michael> (probably like a lot of you :) ) , is there a screencast of git
> > Michael> somewhere (for free) that can demonstrate some of the advanced
> > Michael> features of git...  (Also...I have seen both Randal (Schwartz) and
> > Michael> Linus' (you better know his last name) presentations at google on git
> > Michael> , in which they explain the ideas behind git more than the actual
> > Michael> usage,
> >
> > Having been involved in that screencast that you reference, I'm curious
> > about what you think you're missing in order to use git.  The feedback
> > will help me produce better presentations.
> >
