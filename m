From: Scott Chacon <schacon@gmail.com>
Subject: Re: git-scm.com website
Date: Mon, 9 Mar 2015 10:14:43 -0700
Message-ID: <CAP2yMa+Bw0KCSz9YEtviZUykAp4jpdsEWSK-jRxtd9MjzjHKfg@mail.gmail.com>
References: <CAJo=hJsbbfK-_qX6sg3Azk30Kz5ebLfyMbVF98VzHZe8YyaLcQ@mail.gmail.com>
 <87y4n6kvdu.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 18:15:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV1Go-0002tG-CE
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 18:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbbCIRPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 13:15:05 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:37059 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbbCIRPE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 13:15:04 -0400
Received: by obcwp4 with SMTP id wp4so28145348obc.4
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=C6h7eAG//VVksok4YL6Y4odGQX8tWX+0vS54godiFxQ=;
        b=n3T79agasYc9BEgZTT+DpaG0mSMGy9o2oymdipZ+Ez6H1+zr4zP8uSBylVa02+my8s
         qeASH8uaLXxmAqEGSiCl2yh5n6QuwvsLptocur1IPjg0cRj8MR8W5nBkkLbXebicCN7s
         zeaR8WSL5PG9SIl6tCoEHTVK3kJ/TAG4DDP4Ti1TuvxgZT1KPTO7RrgjKV2PKr1qOwKy
         mx+7BMaetYwCl840miEvexu91tMlDbu1wPJ07berxruq9XrbkPcD6UiY3ySHTj57MCbN
         +FXex0oN6X1HjGLF0aUn5Hj7qeG9ojG6WeqR9F3MWQTb7TpGFcBV+EwkHjA/UJr2KVnO
         6x4g==
X-Received: by 10.202.63.132 with SMTP id m126mr20971630oia.33.1425921303516;
 Mon, 09 Mar 2015 10:15:03 -0700 (PDT)
Received: by 10.182.220.8 with HTTP; Mon, 9 Mar 2015 10:14:43 -0700 (PDT)
In-Reply-To: <87y4n6kvdu.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265182>

Hey,

On Mon, Mar 9, 2015 at 9:06 AM, David Kastrup <dak@gnu.org> wrote:
> > On Mon, Mar 9, 2015 at 6:57 AM, Michael J Gruber
> > <git@drmicha.warpmail.net> wrote:
> >>
> >> Since we're talking business: git-scm.com still looks a bit like a
> >> ProGit/Github promotion site. I don't have anything against either, and
> >> git-scm.com provides a lot of the information that users are looking
> >> for, and that are hard to find anywhere else; it's a landing page. It
> >> just does not look like a "project home".

I'm sorry that you feel this way, but I've tried pretty hard to make
sure the site is as neutral as possible. The only actual place the
string "GitHub" occurs on the landing page is at the bottom where it
says "This open sourced site is hosted on GitHub."  I don't even
mention anywhere that GitHub pays for hosting it. Also, all the Amazon
referrals from Pro Git sales are donated to the Software Freedom
Conservancy and all my personal royalties are donated to charity. It
also very clearly states that the book is free to read online in it's
entirety (which is actually relatively expensive for me personally,
since I personally pay the S3 hosting and bandwidth costs for all the
eBook downloads).

I'm not sure why you think it doesn't look like a "project home". It
has basically all the same information on it that you would find on
any other project home page: a description, direct links to downloads,
source code, documentation, a book, community and development
information, etc. These are basically all the same things found on
sites like http://www.gnu.org/software/emacs/ or
https://subversion.apache.org/.

>
> It features "Companies & Projects Using Git" at the bottom.  Not
> "supporting" but "using".
>
> Linux is point 10 on that list.  The first 6 items are Google, facebook,
> Microsoft, Twitter, LinkedIn, and Netflix.
>
> Even for an OpenSource project that does not buy into the Free Software
> philosophy, that is a mostly embarrassing list of companies to advertise
> for.

Well, there are 16 groups listed on that page and 10 are open source
projects and the remaining 6 are large companies using Git and open
sourcing things using it. The idea of the list is to give people new
to Git confidence that it is widely adopted both in the open source
and corporate worlds. I also am not sure what's "embarrassing" about
these companies - they all heavily participate in the open source
community and many of them sponsor development of projects like Linux
and Git.

>
> Personally, I consider the recent migration of the Emacs repository to
> Git a bigger endorsement but then that's me.

I would love to have Emacs on that page, actually. If you guys want me
to add that, I'm happy to. I didn't know they moved over, I thought
they were still a bzr shop.

>
> It might make sense to reduce this list just to "Projects" since those
> are actually more tangible and verifiable.  Or scrap it altogether.

Sorry, I disagree with this. I think it's helpful for people to see
some important corporations that are using it, since many people
coming to the page are doing research to figure out if they want to
switch to it in their companies. It also demonstrates that these large
companies are participating in the open source community and it may
help them decide to open source internal corporate projects as well,
which I think is beneficial to everyone.

Scott
