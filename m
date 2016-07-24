Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2622203E1
	for <e@80x24.org>; Sun, 24 Jul 2016 18:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbcGXSl2 (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 14:41:28 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33135 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbcGXSl1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 14:41:27 -0400
Received: by mail-pa0-f51.google.com with SMTP id ks6so54051437pab.0
        for <git@vger.kernel.org>; Sun, 24 Jul 2016 11:41:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=H75JJ/LVfIuQZWfzsu0igXhfXqFWYnVRntrHTyoMRnE=;
        b=Q9hlumk7I34IquFVw7I3ULkMB59GEkxLxP3uRVuy9y+Pf8jXp1HqGVJegkq1fwCsvK
         c/d1Hxj0unNxuEKoev2Kw2EtBhOVl019Xbm5QX/tXRUd0X1YQbAlb09mLIO9pjwvzhgP
         kOirRQi+5qrg7WiSa2qe1GOALdHwXhOxuS/NeqHj9AbHrMfHF5L0fkbPeMXA+wLbZ3eR
         Z39Se+APpe+ygF1LWvqGTLlQmfRB3lEvc+pNLRvpohljlkQaKntZF1wZL5D83sBlQxaf
         flKQ8SIfU2JjNFuSvH29/AGvi+874DPvQRfqBUO/yvI5f8KWItEFdX+R7fbOwYcuDnGZ
         Oq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=H75JJ/LVfIuQZWfzsu0igXhfXqFWYnVRntrHTyoMRnE=;
        b=M05qmMcBI7DJVIEC1mrVVFAmwt6v2mKNlgsbJPjRrT9iDzGI0lRucgq5fC1Wsa40JJ
         XNHxuBhP2ilF8l4rVXU/3fmEXGVUBwYAOmJegB//SqYKHRujCXNJ7LkS1AMwmEOZGdXu
         SkmASZl/NbxfNKFMCNlWDRUToyxmWgIoNw16oxGra66O8ePyAUl0tVisawBIbfQ4lYHi
         rcoPLJYpJZWpU+SOXgioRtY8oZqYgYrUtGrrkOmKpKOEW45TENAV3j6ntM0rJDShevd2
         1IGFrrl5x3bM0TnadlIr3n+flIlMXTIgMglz3pmwujh6jaKkGZda+x8dwpAjU2/Ccli9
         LfZQ==
X-Gm-Message-State: AEkooutsxozDztbWbfM2EpfadNK1AniCWx45d9RtOyDhYurjnAHaBbEEjjZCr2/0hNsTkg==
X-Received: by 10.66.101.1 with SMTP id fc1mr22943647pab.84.1469385686224;
        Sun, 24 Jul 2016 11:41:26 -0700 (PDT)
Received: from [192.168.0.109] (c-71-202-183-39.hsd1.ca.comcast.net. [71.202.183.39])
        by smtp.googlemail.com with ESMTPSA id cf1sm34278693pac.20.2016.07.24.11.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2016 11:41:25 -0700 (PDT)
Subject: Re: [ANN] Pro Git Reedited 2nd Edition
To:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
References: <nn1euf$h6q$1@ger.gmane.org> <579483B7.4090508@gmail.com>
 <6f7eea6b-2446-5740-cbec-141d71a33ea1@gmail.com>
 <CANQwDwcy_AXTmG02ynNanNvoNVnK+t3uxf5r1J5tHn1hxaZ9kg@mail.gmail.com>
 <d7918e4a-c4c7-c85f-1aba-3cb9a59e6eba@gmail.com> <5795087C.4010503@gmail.com>
Cc:	git <git@vger.kernel.org>
From:	Jon Forrest <nobozo@gmail.com>
Message-ID: <89e0a631-6396-e56e-0c1d-37acdbf8eda4@gmail.com>
Date:	Sun, 24 Jul 2016 11:41:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <5795087C.4010503@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 7/24/2016 11:27 AM, Jakub Narębski wrote:

> In my opinion being able to view it online has its advantages.
> Even casual reader can check it, and point errors or offer suggestions
> for improvements.

Absolutely. Now that I've finished the editing I'll look
into that.

> I think you can share a folder instead, and this would be stable.
> Alternatively, when updating the book you could update the link
> in the GitHub repository description and/or the README for the
> fork.

I'll check your folder idea. If that's correct then that would
be an excellent way to do it. I had already thought of updating
the README but I'm not sure if this would be sufficient.

> Well, https://git.github.io/htmldocs/git.html is on GitHub Pages
> (for a project, that is in https://github.com/git/git.github.io repo
> that is also used for Git Rev News), and it obviously uses AsciiDoc.

I'll check that.

> You can use Jekyll, or you can just upload HTML, as described
> in https://help.github.com/articles/creating-project-pages-manually/
> (this one is for per-repo GitHub Pages, i.e. using orphan branch
> gh-pages, not a special named repository like e.g. git.github.io).
> After each change / release you would need to rebuild HTML version
> and upload to GitHub pages. This can be automated with hooks.

I'll also look into that.

These are all great suggestions, which I appreciate. I didn't
do any of this for the 1st edition, which, in retrospect,
was probably a mistake.

> BTW. I thought that Pro Git used Markdown, not AsciiDoc?

Nope. Asciidoc. See
https://medium.com/@chacon/living-the-future-of-technical-writing-2f368bd0a272#.fdhsp0zgj

> All right. One issue I have after browsing through changes is that
> description of changes and their granularity is severely lacking.
> "A few more very minor changes.", "More piddly changes.", "should have
> included this in last commit" are not good commit messages.

You're absolutely right. I probably should have squashed those commits.
Those comments aren't really intended for public consumption.
Since I made many changes per commit, I really couldn't give an
instructive commit message.

Now that this edition is done, I plan on following good commit
practices in the future.

> If I find time to comment on changes, I would do that on GitHub,
> commenting / adding notes on changes there (like the one I posted
> as demo:
>   https://github.com/nobozo/progit2/commit/43ae203c2ccf1a017153de1b41a8c47eb166dba1#commitcomment-18372006

That would be great. I think I'm setup for that now in my GitHub
repo for that book.

Jon

