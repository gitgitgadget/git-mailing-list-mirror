From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Fri, 7 Aug 2015 00:18:00 +0200
Message-ID: <CAEcj5uXJnZ+3R+CWoUnpqixrKiiWMQMVjq2YrXYd2brbP9URQg@mail.gmail.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	<xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
	<CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:18:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNTUG-00050F-9N
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 00:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbbHFWSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 18:18:03 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35641 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbbHFWSC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 18:18:02 -0400
Received: by wibxm9 with SMTP id xm9so39745577wib.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 15:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y+OtfSfKkxbYf+xBO6wCKZ4x/HB1H8YLCwUPQyApfbk=;
        b=LB4mmt9Yvix7QigRUz1MOyGWq1xi4DI58RdGIfapWPhBseoRWmECu8Ucj6uMl1HRu9
         AhXgU6a9rrNAYQKM3JeWlaU9HnFGYLKd6XibxJJxSf9Nv/i9TaLT0L8xtyBqZd50cM+W
         mvqW117jOsK73DtOY3cIzR1m9qJmBHdO7VxkfHAqfpqEt4l3hWhhhvquWAqV7c1rSByW
         cODgHJ9TJm3XTMlFOeNqrRWdIZiotwOem4Zvs5K28k8GbfZhwceFJKTmNmSwsc1EOj4b
         A+3uqh74ZkLPmutU1VNulCypCjvkOizIdDvez4EGcWmytwZmmQ1OWh5jS1s+EZ7RRHUB
         wmgA==
X-Received: by 10.180.108.175 with SMTP id hl15mr306534wib.1.1438899480563;
 Thu, 06 Aug 2015 15:18:00 -0700 (PDT)
Received: by 10.27.47.137 with HTTP; Thu, 6 Aug 2015 15:18:00 -0700 (PDT)
In-Reply-To: <CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275448>

On Mon, Aug 3, 2015 at 10:49 PM, Thomas Ferris Nicolaisen
<tfnico@gmail.com> wrote:
> I hope we can attract more contributors in the future, so the weight
> of this doesn't lie too much on his shoulders. Perhaps we should send
> out the draft earlier next time, and beckon for more contributions
> from the list.

Just to follow up on this point: The draft for the next edition is
available here (still empty):

https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-7.md

Suggestions and comments can go here:
https://github.com/git/git.github.io/issues/94

> We could also add a call-for-help at the bottom of the respective
> section, asking people who are trawling the mailing list to
> contribute.

You may have spotted that I added this in the recently published
edition, but I think it can bear repeating here for git@vger:

> Before we move on to the link section of this edition,
> we want to make a "call-to-arms" for people reading
> the Git mailing list. We didn't get enough material in
> this edition on what was really discussed on the list
> the last month. In order to to be the window into the
> Git community that we set out to be, we need your help.
>
> So please, the next time you read through an interesting
> discussion on the mailing list, note down a few lines
> about it and share them with us.

So, thanks in advance for the contributions we get for #7 and later editions!
