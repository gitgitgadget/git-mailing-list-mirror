From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: Our official home page and logo for the Git project
Date: Fri, 11 Apr 2014 12:45:15 -0700
Message-ID: <CAL=YDW=LkvPq8-9Jv76MkN=7CzTmdXRF2-W66w+y-gprD7rpXQ@mail.gmail.com>
References: <xmqq7g6z4q6b.fsf@gitster.dls.corp.google.com>
	<534578b2e22e2_af197d3081@nysa.notmuch>
	<CAH5451kNoXobbh3-WBkewvKvNeFkV0P14Z55=qDN+Ak2WGkHSA@mail.gmail.com>
	<20140411114017.GC28858@sigill.intra.peff.net>
	<xmqqr453sm76.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:45:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYhO9-0007PF-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754382AbaDKTpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:45:18 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:43146 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaDKTpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:45:17 -0400
Received: by mail-vc0-f178.google.com with SMTP id im17so5123498vcb.23
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JIT7822b6ZinEAv/9CkTAWgVypLoXJMrftH2aaVyU3Y=;
        b=JkGYJ7FgwVGV9ZPd8O7yMYrZhD6ts28O0aqDGPP4QntuinBhCo8kP20Fev3sJkvEO0
         BMQwXhENVVWu54BI4kJSwUUjGKykhP0WJu/+3rGqskuuLKQHBPacjt4ASnbzIbA5Qq2s
         39cKjnjJHGhT6PEqYo9FH2GpgGtZzJS/zPsERSZd7vq+jfDw/J39kK+tbXJ/xWVUq/fw
         6cl0uXWSvRMVb2DLMLH6Qs83OJGhwelu0HBR6icKQc1/COhRGk5r+ZVDFHO3Y+A0z6QK
         dKRAhXO6F0+9Y45ZgTRKgAIWRmJleyhW1e9+pvsCPQgwHPsYeo2mN3pyvfwt7mWqXDEQ
         rc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JIT7822b6ZinEAv/9CkTAWgVypLoXJMrftH2aaVyU3Y=;
        b=FlGDd2hp9FVIj7rge49MscrPTMGwH1Mkat3z/33HuCxpdog+UhLqHx+t32f4egkqx+
         RFfNA5r6BWWcmW+IfkStIL/EBKShnif/imeWn5XkcU89J4KPseXC5BCup9eygiGYwyA4
         rasEuNlytw0URPPuwKmDz7tuWQdWXx29obn2o3IL//t8EtrWrQxuKb20oGH/etxJ9zfR
         bqDZBtgty7wy50u8ie0bUIJ4mMBXxZUUFllq5B53k61MAAztPghLOYtJLJdvrs1HTJy4
         IL6xpghz9q1kb+DSdFh8TwjITkdhcWuNxr1L7goMXMm701itIGO+9TPl9ETlYC0ryO7c
         Ns+g==
X-Gm-Message-State: ALoCoQmklim1MMSUp80ZmA9Iy2q/WBl43DWGaiV2/0a+2hunG7et7wftJqQbg7Uglb59AWmzwtmNcBpq4ASHOKIm760v+Cen/wYvU/uhlgQmdabRkIQQGfLr1z9FUisHjJ8547SmQeD1jUzqAjjxXcpqvyOlmTjayCUqQ5eW8rVmZEIk6Gh0I6ir/uW/u4aI1ySTj4Ff7c29
X-Received: by 10.58.107.65 with SMTP id ha1mr21583581veb.1.1397245516091;
 Fri, 11 Apr 2014 12:45:16 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Fri, 11 Apr 2014 12:45:15 -0700 (PDT)
In-Reply-To: <xmqqr453sm76.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246137>

On Fri, Apr 11, 2014 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:

>     Please help us by letting us answer "Yup, that is a logo (among
>     others) that represents our project, and we are OK with you
>     using it to help promote our project" instead.
>
> That is what I meant by "our official logo" in the first message.
>
> So,... seconds?

+1
