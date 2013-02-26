From: Jaseem Abid <jaseemabid@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 26 Feb 2013 10:29:54 +0530
Message-ID: <CAH-tXsAPWuF3bBSMJF-rjxhn0bfMOJ-RVUaNz4rWT_hoQJdg2w@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 26 06:01:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UACfN-00051n-Aj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 06:01:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab3BZFAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 00:00:43 -0500
Received: from mail-ve0-f178.google.com ([209.85.128.178]:57962 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab3BZFAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 00:00:35 -0500
Received: by mail-ve0-f178.google.com with SMTP id db10so2942789veb.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 21:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4/1rqeXWIad3f1jFS83ZU8sQ94qSdZH9+ctrFE6Zw9c=;
        b=sfxidbZ+DQLfVq/eZErVyafyb2zGPZ7XyRz4582+9z2/y85zbN8TwJLN2yPZLFNnfX
         VgT7zWrEiLyjyF4FsS/1MQoAInSVxmC4Uj9WFZtwrO9h8e/LDrR5+do35adZVLbGHe0h
         ng+Kq0Q7PCSc9gBxQuOgRiwS54OOwRp/sx90bCssK9uWSdJc3DI0Ymjveke/HNgOblew
         HoTvk1Bbd5p1FoeFOWvHvoYEbFWZg0G34NEz2UJwkfU6cYN8yOFtwDUtao0DjnK/8Ibc
         6KzCb5bYWImsTlKuBQ0C34nNDmfWfcgfOucFl3ptZpZtliYAAhph7vvhKk5vSr1iO9Kr
         WDBA==
X-Received: by 10.52.18.148 with SMTP id w20mr9619935vdd.8.1361854834189; Mon,
 25 Feb 2013 21:00:34 -0800 (PST)
Received: by 10.220.216.132 with HTTP; Mon, 25 Feb 2013 20:59:54 -0800 (PST)
In-Reply-To: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217127>

On Mon, Feb 18, 2013 at 10:53 PM, Thomas Rast <trast@inf.ethz.ch> wrote:

> * We should prepare an "ideas page".  Last year, Peff made one on
>     https://github.com/peff/git/wiki/SoC-2012-Ideas

[Resending the mail, because the last one failed because of inline html content]

One of the proposed ideas last year - 'Use JavaScript library /
framework in gitweb'

I wanted to work on this project last year, but Git community didn't
get a slot for the project from Google. I still worked on it and
almost finished it. Sadly I never got time to polish it to merge to
master. you can see some of my commits on it here.
https://github.com/jaseemabid/git/commits/gitweb

Detailed notes on what actually did.
https://gist.github.com/jaseemabid/3218461


Gitweb is 1 huge perl script and even though it *works*, it is a poor
work in 2013. The code is pretty old and is a hard thing to jump into.
Quite a few here helped me to get started and it was a pretty good
experience. Jakub was the mentor. Ram and John 'warthog' Hawley
occasionally helped with git and general feedback back then. Andrew
Sayers <andrew-git@pileofstuff.org> helped a lot, but he just
disappeared one day.  I remember John mentioning about splitting the
file into smaller ones, rewriting some sections, adding more
documentation etc. I'm not sure if any work was done on this. I
couldn't follow the project for sometime.

I will try to make some time and finish it off in the next week or so.
I am having a bad schedule now between school and job, but will try my
level best.

--
Regards,

Jaseem Abid
github.com/jaseemabid
