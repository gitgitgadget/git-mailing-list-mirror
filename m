From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com
Date: Fri, 25 Jul 2008 14:46:09 -0700
Message-ID: <d411cc4a0807251446k6b7426fbg3ccb2be7de27dc1a@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <bd6139dc0807251420x32e65e73o8db5d77c8b841947@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 23:47:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMV89-0000YA-Mi
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 23:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYGYVqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYGYVqQ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 17:46:16 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:3987 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYGYVqP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 17:46:15 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3627017rvb.1
        for <git@vger.kernel.org>; Fri, 25 Jul 2008 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DLTEz5bGJkSivfxqKVg7SQJ+OIQC06Gj7o2wn3QALWg=;
        b=ny+C4/907iaxiYbepNT7craqANQAjPnrxrTuZcJM4jCSIcmB7NVgf9lftmZOedSL4U
         ceUu8wMSbVEhoC4zX1suAeeGRRFHiPn+2mG/AHUGLj46GBaY4xbMTQ26gH4P1frI/36a
         9JDYODXcZ2iqH32hP6utliBbviWMPJMB4S1LM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qAFJ36qH+8i3WN+Ous2iCWEue2OZ/EKXDlYn+dHdTpfqC53RzVHGM77dlfrxGpnHIx
         7eNOtQrjv+s2fEBa3O7ubqrCXcW9VacuUhz7B/nYyrWMclpJGWRpR6KjfQj6i7Yj88sE
         eOBFoYmiC5CMrmu+yrUnpk+lhRPnDZmG4c2tM=
Received: by 10.114.192.17 with SMTP id p17mr2674648waf.29.1217022369539;
        Fri, 25 Jul 2008 14:46:09 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Fri, 25 Jul 2008 14:46:09 -0700 (PDT)
In-Reply-To: <bd6139dc0807251420x32e65e73o8db5d77c8b841947@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90121>

I mean to have the new documentation I'm beginning be the
'eye-catcher' on that page eventually.  Not because it's done by me,
but because it will be open and I want to encourage people to
contribute to it (we must make it perfect, after all) :)  However, the
big thing is that I couldn't think of a _single_ resource that I would
want to point people at.  I tried to split everything up
categorically, but I don't know what you're looking for being there
exactly.  Thanks for the feedback, though, I'll see what I can do.

As for my own plug, I feel kinda bad about that, but I have gotten a
lot of feedback that it's a useful resource and I thought by
separating it out into a 'books' section, I had cleanly distinguished
between the corporate sellouts and everyone else :)  I have Git Magic
in the Tutorials section, including a nice plug for it and a link to
it's source on Github - if it were an e-book (had a pdf version and a
cover) I would happily put it over there.  I would like, however, to
keep the downloadable resources seperate from the free online
resources (though now that I think about it, I should probably put
"Git from the Bottom Up" pdf up there somewhere...).  I want people to
know they have to shell out money for those greedy bastards projects,
though.  There will be an O'Reilly book soon, and I'll put that up,
too. If you have other resources that you think are really good, let
me know so I can add them.

Scott

On Fri, Jul 25, 2008 at 2:20 PM, Sverre Rabbelier <alturin@gmail.com> wrote:
> On Fri, Jul 25, 2008 at 19:35, Scott Chacon <schacon@gmail.com> wrote:
>> A followup on the post I did a few days ago about Git documentation.
>> I forked Petr's git.or.cz site and put up a version that I think is a
>> bit more accessible and newbie-friendly at git-scm.com.  I had meant
>> to discuss this with Petr before posting it to you all, but I
>> published a blog post that got a bit more attention than I expected,
>> and I didn't want you all to think I didn't care about your opinion,
>> as some have already accused me of.
>
> I had a looksie at the site and I think the documentation section [0]
> could use some TLC. It might be because it's getting late, but there's
> not really any 'eye catchers', no "CLICK ME!" link for someone
> browsing around looking for Documentation. In order to find what you
> want you have to read -a lot- of the page, which I think is a sign
> that the page would do well with some TLC ;).
> Now I'll admit that the git.or.cz version [1] is a lot worse, but with
> this being an attempt to make it a lot more newbie friendly...
>
> [0] http://git-scm.com/documentation
> [1] http://git.or.cz/gitwiki/GitDocumentation
>
> PS: I think you forgot the </shameless plug> when you did put up your
> own e-book in the books section but did not put "Git Magic" there ;).
>
> --
> Cheers,
>
> Sverre Rabbelier
>
