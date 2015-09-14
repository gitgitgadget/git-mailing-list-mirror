From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Developing- Where to Start
Date: Mon, 14 Sep 2015 23:30:57 +0200
Message-ID: <CAP8UFD1NSAKsJDrav6dBF=92Ba9KY-MVtEydQPqfpSNrReSArw@mail.gmail.com>
References: <CAMTS3bMxb1ak4YHTEU7FYoLVnkmV=4NehQ+obCSp9gV6gFBx_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Breanna Devore-McDonald <Breanna.S.Devore-McDonald.1@nd.edu>
X-From: git-owner@vger.kernel.org Mon Sep 14 23:31:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbbL7-0005tp-0q
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 23:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbbINVbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 17:31:00 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33428 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbINVa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 17:30:59 -0400
Received: by lbbvu2 with SMTP id vu2so2379892lbb.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=95M2/UGTJ3aI7MuILZdkhqjusdLZXfH/PR4JvWYEBxg=;
        b=zCQ6INbx4FsezKZe0JjeHdoJAttRClUD+WGt9Trg86xAWdc8mKK2m+3/ffNAcAh5DA
         mTnAjy3WDYMkbT4025Zh9CT7K7A5yeUzD9C32JZby2hckKjNHGodrJHSksEn62KWZVWu
         DMplRvlsmOq962U6+D1pCFoDgXbdIDvmVsSvxbNvVUm111rgrDPQ+SL3SidbbxghGKMr
         GG5usgkcBPytA79Tt7EkRZvpUThwwXorSx1+w/AkS3EYGbKDXir3N89oQcvzf5gICPny
         o9hKZfxBR2u8O1k4UB+iLlPodmFyB+yTIUDU1p5/hFVlFy/BaVeA/Fs1T9NEK0tPYxAt
         WhHw==
X-Received: by 10.112.87.69 with SMTP id v5mr16846992lbz.70.1442266257614;
 Mon, 14 Sep 2015 14:30:57 -0700 (PDT)
Received: by 10.25.161.78 with HTTP; Mon, 14 Sep 2015 14:30:57 -0700 (PDT)
In-Reply-To: <CAMTS3bMxb1ak4YHTEU7FYoLVnkmV=4NehQ+obCSp9gV6gFBx_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277865>

Hi,

On Mon, Sep 14, 2015 at 10:42 PM, Breanna Devore-McDonald
<Breanna.S.Devore-McDonald.1@nd.edu> wrote:
> Hello all,
>
> I'm a third year Computer Science student at the University of Notre
> Dame, and for the final project of my Data Structures class, my group
> and I have to find a way to contribute our (hopefully) newly-found
> data structures and optimization knowledge to a well-known open source
> project. We thought Git would be a great project to work on, but we
> have no idea where to start. Can anyone offer ideas or parts of the
> code that we could possibly help with? (a problem that is data
> structures-related would be extremely helpful!)

The Git project often participate in the Google Summer of Code.

This year we used the following resources to help potential GSoC
students get involved in developing Git and find a project to work on:

http://git.github.io/SoC-2015-Microprojects.html
http://git.github.io/SoC-2015-Ideas.html

A GSoC wrap up has been written recently in Git Rev News edition 7:

http://git.github.io/rev_news/2015/09/09/edition-7/

Earlier this year students from Ensimag (Grenoble, France) also
contributed to Git and a small wrap up is available in Git Rev News
edition 5:

http://git.github.io/rev_news/2015/07/08/edition-5/

I hope this will help you get started in your Git development journey.

Best,
Christian.
