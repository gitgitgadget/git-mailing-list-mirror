From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Should git-remote-hg/bzr be part of the core?
Date: Mon, 12 May 2014 18:13:34 +0200
Message-ID: <CALbm-EboY+a38uyge1fjYnQuq-Yk2QXG+31tWNap8bX85Hwa4Q@mail.gmail.com>
References: <537008f06ceb8_8e47492f89f@nysa.notmuch>
	<53709788.2050201@alum.mit.edu>
	<CAHVLzcmqdkf4fMTok+HsXcDOQ5Oz2QdZti3FuzgBUa2T6AWnfA@mail.gmail.com>
	<5370c32d7ffc7_168f13a72fc6b@nysa.notmuch>
	<CAHVLzckDnfFQpZ-u8qdmKqaCNk62b_K_yinfamBPgm1oST1eLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	git-fc <git-fc@googlegroups.com>,
	Richard Hansen <rhansen@bbn.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Christophe Simonis <christophe@kn.gl>,
	Dusty Phillips <dusty@linux.ca>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 18:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjsrE-00026z-OX
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 18:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbaELQNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 12:13:36 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:55944 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbaELQNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 12:13:35 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm4so4785419wib.11
        for <git@vger.kernel.org>; Mon, 12 May 2014 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MYHsQLC0iJhCgMkqw8lqSQcxm3DqL2FkfFjW+Zs3AA8=;
        b=bEuZ3+Kvp2aQdsC7yChda0nT1vMXCj6YrbkNX3rauiZG3xjmSCSce7tvHUeJGViuHR
         vfje2iSS0gThbPC8SmVwPO7mU7U+PVzZUTAvzYmY8c8LI4irV0LoSnJuCX8na0PVbgId
         mgfK+LEQtm82PxMCxNJroCilyVexHJ6ykz5XQXjOYpJzXkv+RWUYbmfxYT0cnCDR0LHV
         Mdgmi+HDw4/iZ25SN5Kpisz6f436IZp3YghXGNGCx9g/yjDw6BPToCzM6OTeN9X0EbGk
         x1Fy9j9TE2zO8gq254+4ty8ksULYWcwVRoiIPvO9M2b0OLryZgu4sYRCrUJ4ctXqv3oR
         M46A==
X-Received: by 10.180.207.47 with SMTP id lt15mr16367952wic.46.1399911214689;
 Mon, 12 May 2014 09:13:34 -0700 (PDT)
Received: by 10.180.94.166 with HTTP; Mon, 12 May 2014 09:13:34 -0700 (PDT)
In-Reply-To: <CAHVLzckDnfFQpZ-u8qdmKqaCNk62b_K_yinfamBPgm1oST1eLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248711>

2014-05-12 15:45 GMT+02:00 Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>:

>
> No, sorry but I'm NOT interested in lying to git community.
>

It's not lying. See the "Helped-By: <>" lines in git.git commits.
Often the help was formulating a correct and easy-to-understand
commit message.
