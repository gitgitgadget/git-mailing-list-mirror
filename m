From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2012, #02; Fri, 9)
Date: Fri, 9 Nov 2012 21:06:47 +0100
Message-ID: <CAN0XMOL1SS2iiJkZyt3HACoCRXE1nGrd52B2rscWyS1e7X0GWQ@mail.gmail.com>
References: <20121109192336.GA9401@sigill.intra.peff.net>
	<CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 21:07:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWur1-0006WY-6B
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 21:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab2KIUGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 15:06:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:64434 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab2KIUGs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 15:06:48 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so1913385wey.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vKodIpw6LJ9u4AzzkbgEN9yb5lBnBlXrGjFp5YJbTA4=;
        b=wYYzW/15ATFS3x7P17e7Q3ywk20LDDUeSD0Qo9EOLzSbpensNDtkbiwjkNQotFD1ao
         OnmBYPSI1Fhb4hOpv1xvnOnmQBe33anIyyNHlvfmbWTD8Q9ZPtniF5S8IMWD9jOgUYTn
         uBwkl9XYJPBzY69z8QcBeR6rOm6BqzSRCQf5BRLf5quLXV2RDjpNHttLfBy0NOFubLfI
         D4zz+qvXAYUJxCQ8MTUSM3Xc1Y3ijY3cWRACdivzQcRw5RjqAmYFnhfvYezj4vF5lj6K
         T7sm9ohlAAByFOUF9OOqz2EhYGfeiMFce2qFIo/dNMBiBP+2UHvX0A1c8DmvSpwIQq3u
         boPA==
Received: by 10.216.197.142 with SMTP id t14mr4994753wen.151.1352491607630;
 Fri, 09 Nov 2012 12:06:47 -0800 (PST)
Received: by 10.194.163.68 with HTTP; Fri, 9 Nov 2012 12:06:47 -0800 (PST)
In-Reply-To: <CAN0XMO+sgSgkqK7D6=5NL--rMYBwsGohgQ7v+ja4Twub20N1sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209245>

On Fri, Nov 9, 2012 at 9:01 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> On Fri, Nov 9, 2012 at 8:23 PM, Jeff King <peff@peff.net> wrote:
>>
>> You can find the changes described here in the integration branches of
>> my repository at:
>>
>>   git://github.com/peff/git.git
>
> It seems that the repo doesn't contain the integration branches?!?
>
> $ git remote add peff git://github.com/peff/git.git
> $ git fetch -v peff
> From git://github.com/peff/git
>  * [new branch]      maint      -> peff/maint
>  * [new branch]      master     -> peff/master
>  * [new branch]      next       -> peff/next
>  * [new branch]      pu         -> peff/pu
>  * [new branch]      todo       -> peff/todo
> $

But "integration branches" means "master", "next" and "pu" than I haven't
said anything. ;) Sorry for the noise.
