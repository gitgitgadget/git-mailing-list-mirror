From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Re: [GSOC] Contributing to git.
Date: Mon, 2 Apr 2012 15:32:46 +0800
Message-ID: <CAEY4ZpNek5-8s6hG8qUos9TfNEn83Hf4KCyCcreY3MM5P9qAkw@mail.gmail.com>
References: <CAH-tXsB39OpbmVcD3Fd+tq8UcBsyCf6JBZ-rSyf1VwrQPKLiFQ@mail.gmail.com>
	<201203301305.23567.jnareb@gmail.com>
	<CAH-tXsAMJXNs7fM=9msiZT+F_s_06o526kPXLLcQzABBePHxwQ@mail.gmail.com>
	<201203310137.59657.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jaseem abid <jaseemabid@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 09:32:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEbky-0004GT-CA
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 09:32:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab2DBHcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 03:32:47 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33034 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab2DBHcr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 03:32:47 -0400
Received: by vcqp1 with SMTP id p1so1490680vcq.19
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 00:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qR0A8V8jkDDSe0r7YXWZhxtK3apg7R2iqugesax6hVM=;
        b=bMiHrguinIt5NS7S+Ktoj5yCEl35Rficj6/pP+AoaevPFlgiWLCAUM/UmjFTcKRLEP
         ZPytWv/HAgpe/HC3IKqmrtWlR+JSW/1YcOCsw9dV7iIvIN0NJ0x1dz8L+bzUu0oGC+M9
         yznLTI3ZqYGWrNQlhuGYN/aY6nLuLaRWqYV6zBTlgAgP+gnoiGb6O5XvqelF2iOMgwta
         x6c9e4OyDnZbKRstr+T9Spm02Z0mw56swaHdIhUJrjwlgpZSY5+xBSBBjQVLMGtnQ9+o
         XcHlqJEKD7R38c5dbv6mltQ2HZdFyvbRWH8nNV3MJ+D9pXZrpKpCnTWdyf5y02DShCUA
         YbtA==
Received: by 10.220.38.200 with SMTP id c8mr3552964vce.28.1333351966420; Mon,
 02 Apr 2012 00:32:46 -0700 (PDT)
Received: by 10.220.171.193 with HTTP; Mon, 2 Apr 2012 00:32:46 -0700 (PDT)
In-Reply-To: <201203310137.59657.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194499>

On Sat, Mar 31, 2012 at 7:37 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Test.Simple and Test.More (http://search.cpan.org/dist/JS-Test-Simple/)
> both output TAP (they are port of Perl's Test::Simple and Test::More);
> part of JS::Test::Simple.
>
> Node.js requires V8 JavaScript engine from Google; if we have that, we
> can as well use e.g. JavaScript::V8x::TestMoreish[2] from CPAN.
>
> Other solutions include using Test::JavaScript (uses SpiderMonkey
> JavaScript engine), or Selenium.
>
> [2] http://search.cpan.org/perldoc?JavaScript::V8x::TestMoreish

Just to add to the discussion, consider these too (descriptions copied
verbatim off their tins):

1. phantomjs[1] - headless WebKit with JavaScript API
2. casperjs[2] - navigation scripting & testing utility for PhantomJS

[1] http://www.phantomjs.org/
[2] http://casperjs.org/

nazri
