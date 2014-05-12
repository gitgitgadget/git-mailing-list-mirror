From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 15:45:13 +0200
Message-ID: <CAHVLzckDnfFQpZ-u8qdmKqaCNk62b_K_yinfamBPgm1oST1eLQ@mail.gmail.com>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch> <53709788.2050201@alum.mit.edu>
 <CAHVLzcmqdkf4fMTok+HsXcDOQ5Oz2QdZti3FuzgBUa2T6AWnfA@mail.gmail.com> <5370c32d7ffc7_168f13a72fc6b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	git-fc <git-fc@googlegroups.com>,
	Richard Hansen <rhansen@bbn.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 15:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjqY0-0005jG-0U
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 15:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbaELNpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 09:45:35 -0400
Received: from mail-qa0-f50.google.com ([209.85.216.50]:42776 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaELNpe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 09:45:34 -0400
Received: by mail-qa0-f50.google.com with SMTP id j15so6976741qaq.23
        for <git@vger.kernel.org>; Mon, 12 May 2014 06:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gxU3uUE1P65QcGK1ReDvySKx3032iQBq+Z04geo7shE=;
        b=mDHOFHj/IP69g4xVqglH78lOjlY0Pd6UJp8+cixFJOWJ7xR2LMtvUs87LvTcXlp0Ku
         cIMVvOTC/E9IPcf1GYwxf8lnjaPKUSWGkF2cRw5SCMBYjn/gWtc4I3PZebxGfZbu7A2X
         ATGyvyw2LAbELGKlzV4emHZ4vm5kRHZfLTA9EOpcdMdT0uPDpUZQ0WYrH+TsmkTzM0W0
         SAmmBkBqVCrUk1SbIlYmzJM2QrT36ld+0pkqUMwT4MgwyGGjpsdPGVOkTdquXSHZll7C
         mtr1udlODay0bPG8oJ802Ny42DgqLyggsnhFz8ZUiSH9rCmzpj8IqejTtr2mVcWodgMY
         EBWw==
X-Received: by 10.224.56.5 with SMTP id w5mr38014779qag.60.1399902333546; Mon,
 12 May 2014 06:45:33 -0700 (PDT)
Received: by 10.140.94.171 with HTTP; Mon, 12 May 2014 06:45:13 -0700 (PDT)
In-Reply-To: <5370c32d7ffc7_168f13a72fc6b@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248708>

On Mon, May 12, 2014 at 2:48 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Paolo Ciarrocchi wrote:
> > On Mon, May 12, 2014 at 11:42 AM, Michael Haggerty <mhagger@alum.mit.edu>wrote:
> >

> > While I agree with you the this project is managed in a bit conservative
> > way
>
> Only a bit? I don't think I've been involed in a more conservative open
> source project.
>
> > you should really improve how you communicate with other developers,
> > it's such a pity your contributions are some times not included in
> > git.git just because of your attitude.
>
> But that's a theory. You don't *know* that they would have been included
> had I used a different attitude.

Well, you could at least try to act and communicate differently.

> In fact, people have contacted me privately saying similar things, and
> I'll give you the same challenge I gave them. If you think a different
> attitude would get my patches in, how about *you* write the commit
> messages and the discussions for one of my stuck patch series. I'll send
> the mails as if I had written the content.

No, sorry but I'm NOT interested in lying to git community.

Ciao,
-- 
Paolo
