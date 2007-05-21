From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/6] Remove whitespace breakage from *.c files
Date: Mon, 21 May 2007 13:54:11 +0200
Message-ID: <e5bfff550705210454s6e89fb2frb8cb74ea97d7c2ca@mail.gmail.com>
References: <4650222D.4070707@gmail.com>
	 <7vfy5rjhyq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 13:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq6T4-00058y-Ub
	for gcvg-git@gmane.org; Mon, 21 May 2007 13:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755459AbXEULyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 07:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755746AbXEULyQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 07:54:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:17483 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbXEULyP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 07:54:15 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1356078wra
        for <git@vger.kernel.org>; Mon, 21 May 2007 04:54:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYAA5kzrL9reSUL+/gqxEGaBY5odIjK+rIZoBfyHPSesSrnKk8QzrSICYRfsB0KFym2Eip/sPwEJAyR43pjM5jRv5R7+7qAo2bkpeO1mjNIr6MMQxejvX+/5q6AhE59N76gbq+Btu42M8rZx08gO0e2uuIbhk0+5szKuhE5rdWU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qgQpJ3ixmGXMu4ErnpLACtFPqIVCOprodP6Yown5wnTQ0Z1CJsXKI7GNAl1eRbZIbdXERhmW2gOqabwfR01iXOtSjpJOB/gaZ36WYxHPSWc0E9QceeTP+hGwjmnCr8w3sN2TZuRl9FdSHulNeoZIsbNr6CE+LQx12Ir0Q0HiUNg=
Received: by 10.115.55.1 with SMTP id h1mr2630211wak.1179748451190;
        Mon, 21 May 2007 04:54:11 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 21 May 2007 04:54:11 -0700 (PDT)
In-Reply-To: <7vfy5rjhyq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48012>

On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
> Your MUA seem to have munged all your patches in this series;
> and the breakage seems also to be in the "let apply eat the new
> trailing blank lines" patch.
>

I'm very sorry about this. I have set maximum length to 120 chars in
Thunderbird, but probably there's something more to tweak.

I can resend all the patches next week-end if you want. But please
feel free to create and apply the patches yourself when you prefer. I
understand that this kind of patches are mostly automatically created
and also touch a lot of files so the manteiner has the best _timing_
to create and apply them.

Marco
