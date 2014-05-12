From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 07:48:45 -0500
Message-ID: <5370c32d7ffc7_168f13a72fc6b@nysa.notmuch>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
 <53709788.2050201@alum.mit.edu>
 <CAHVLzcmqdkf4fMTok+HsXcDOQ5Oz2QdZti3FuzgBUa2T6AWnfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	git-fc@googlegroups.com, Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon May 12 14:59:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjppZ-0002m5-6O
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 14:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758228AbaELM7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 08:59:41 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63761 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbaELM7k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 08:59:40 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so8130145obc.32
        for <git@vger.kernel.org>; Mon, 12 May 2014 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=dGFktKtOvoMspSwjEkn3/hDSj4jAV/oKgMyQ56bzcUk=;
        b=CKJELRbyriJ1X7MLlaBrHI35mmlbSqUVl0ml94f4+8RpO5953U+T0klhaAqDiO6dxx
         99EIdf/7H+K/lgDml1Ji4FmRkgYlLbr13WoczxN4ZblwdXYoZjydny8AOJXkAYxuBGGR
         cLMgaQ9Xeh3HC+zzkNkXVbnG5Dkr0nzc1knaTGp5J4G47ELn7f4LYCp4nsFcRkLbt/bj
         Gt2UowjrwdOVR4D1mBf8RY9erzKd5axT+DL2kdTOvmwK327nzUeWkBhSJX8tFiqudL34
         mwCyu7+vzy8pZoaQtK8tW688Z0LX5f3qTA6i91GTV2vZ26XDx4QssKn9HCBN11auNB2h
         JG5w==
X-Received: by 10.60.155.33 with SMTP id vt1mr15522216oeb.3.1399899580393;
        Mon, 12 May 2014 05:59:40 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id e16sm20139322obs.26.2014.05.12.05.59.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 05:59:39 -0700 (PDT)
In-Reply-To: <CAHVLzcmqdkf4fMTok+HsXcDOQ5Oz2QdZti3FuzgBUa2T6AWnfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248705>

Paolo Ciarrocchi wrote:
> On Mon, May 12, 2014 at 11:42 AM, Michael Haggerty <mhagger@alum.mit.edu>wrote:
> 
> > Felipe, you seem to have so much potential.  If you would put as
> > much effort in conducting social interactions as you do in coding,
> > the whole balance would change entirely, and any software project
> > would be happy to have you.  With all my heart I truly wish you the
> > best in your future endeavors.
> 
> I really *love* this paragraph. Felipe, you are a brilliant developer
> and you put a lot of work trying to improve GIT.

Thanks.

> While I agree with you the this project is managed in a bit conservative
> way

Only a bit? I don't think I've been involed in a more conservative open
source project.

> you should really improve how you communicate with other developers,
> it's such a pity your contributions are some times not included in
> git.git just because of your attitude.

But that's a theory. You don't *know* that they would have been included
had I used a different attitude.

In fact, people have contacted me privately saying similar things, and
I'll give you the same challenge I gave them. If you think a different
attitude would get my patches in, how about *you* write the commit
messages and the discussions for one of my stuck patch series. I'll send
the mails as if I had written the content.

If you are right, the different attitude would make the patches land in
no time. I still think it's not right for patches to be rejected simply
because of attitude, but I would accept you were right.

But I think you already know that won't happen, the patches still won't
get in, not because of the attitude, but because of what they are trying
to do: change things.

So if I *know* certain feature would be useful for Git users, I've
listened to all the comments, and addressed all the problems, why would
I give up on those patches? Why would I work on something more boring
that won't benefit users as much but would have higher chances of
getting in?

I'm doing this on my own free time, I can choose to do whatever I want,
in whatever way I want, so no, I'll keep working on what I think is
important.

If you really think the patches can be accepted with a different
attitude, by all means, let's do the experiment and find out.

-- 
Felipe Contreras
