From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 9 Nov 2012 21:01:00 +0100
Message-ID: <CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
References: <20121109192336.GA9401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:01:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWulR-000293-6J
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 21:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab2KIUBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 15:01:04 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:60231 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689Ab2KIUBB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 15:01:01 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so2784381wgb.1
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QWMxgYw0idW2LPKyLXKlLjB4W2JTYEe4bage+RQmAl4=;
        b=rlryudYkp2wnEm0OGFYnCkimzCGycj7axUa65qNwEfAocOE4UD526aykLN34xf0e9A
         tgKiRcIJVV4aGqnCkRPi8cK5y/W9dOgLnDAo/iG2joLrG+DdVs5ZLrT1BeXEKVGLWLxU
         VEYl+iPFvrjV2IxJZXl4XUB7iSs8q25d8lspSWfDYziJw8R7NYfRE8yghPfEGK2mJ2dB
         8q+isNBOJRZLq4bJmYF5jko7KM+u2SvZnv9KRfXhK3hRjP5Pk2+90/rZXfK0jVVW5/+m
         PuFFzgAuVUqa/jA8S8aOF7NUqZQMp1Z3lD/+Nqf35wYj5wfvohNl6zEHk6+/6/DpO0RT
         W1aA==
Received: by 10.180.99.194 with SMTP id es2mr4355229wib.15.1352491260477; Fri,
 09 Nov 2012 12:01:00 -0800 (PST)
Received: by 10.194.163.68 with HTTP; Fri, 9 Nov 2012 12:01:00 -0800 (PST)
In-Reply-To: <20121109192336.GA9401@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209244>

On Fri, Nov 9, 2012 at 8:23 PM, Jeff King <peff@peff.net> wrote:
>
> You can find the changes described here in the integration branches of
> my repository at:
>
>   git://github.com/peff/git.git

It seems that the repo doesn't contain the integration branches?!?

$ git remote add peff git://github.com/peff/git.git
$ git fetch -v peff
From git://github.com/peff/git
 * [new branch]      maint      -> peff/maint
 * [new branch]      master     -> peff/master
 * [new branch]      next       -> peff/next
 * [new branch]      pu         -> peff/pu
 * [new branch]      todo       -> peff/todo
$
