From: Adam Spiers <git@adamspiers.org>
Subject: Re: Hold your fire, please
Date: Sat, 29 Dec 2012 15:09:32 +0000
Message-ID: <CAOkDyE80NX9rw==7uqcKqGvXq07A74Gy7Zu69p7MYe7drvKHRQ@mail.gmail.com>
References: <7vd2y1rix1.fsf@alter.siamese.dyndns.org>
	<7vehi9hgz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 16:10:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Toy2w-0002CJ-J1
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 16:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952Ab2L2PJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 10:09:35 -0500
Received: from mail-wg0-f49.google.com ([74.125.82.49]:44235 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012Ab2L2PJe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 10:09:34 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so5352568wgd.16
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 07:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WUDXfSFvckwyQ3RzNViC3uYtbNuz6e6i0CVxgnnrMDM=;
        b=YqFgvoiGrkycwS0GgE3w34uVQXC6h/VFMW3ZuqKmgXRu/V5XtWb4/YcQbNDDU9IdGO
         gP8SPmeYT+69Jb7YdjoN3pG7NAel+X2b3w/yXJJS+ZsiwD+H/+v7RxLl4HJR6i55RzYd
         iwh7LwQhpBuFgbO4ISA1daUZLWLks7E9SARtTyAB+yIaXy+zWc2973aTAmUUl4oSyg62
         wBRHNnoRaj3IT6CJ17JfUN2HPwrExANSqYlJqhWQc0Abc9UuLSOf3kGsg48z4nFaFwmw
         Dm5W9ciibXhEg9fakEIhZ++sRraQyQp+rjjqSYWm9BXgJ6Q+OB6ECD7ZQBISq6rLYN4K
         +0NQ==
Received: by 10.180.82.69 with SMTP id g5mr57488262wiy.21.1356793772535; Sat,
 29 Dec 2012 07:09:32 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Sat, 29 Dec 2012 07:09:32 -0800 (PST)
In-Reply-To: <7vehi9hgz3.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ZYMZIgMMYuWN83pfZq-0DC5lDOI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212312>

On Fri, Dec 28, 2012 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Primarily in order to force me concentrate on the releng for the
>> upcoming release, and also to encourage contributors to focus on
>> finding and fixing any last minute regressions (rather than
>> distracting others by showing publicly scratching their itches), I
>> won't be queuing any patch that is not a regression fix, at least
>> for the next few days.  I may not even review them.
>>
>> Thanks.
>
> Just as a friendly reminder, I am reposting this to remind people.

Ah, I thought this period had elapsed already.  I assume this applies
to check-ignore, in which case how long should I hold off before
submitting v4?

>> And have a nice holiday if you are in areas where it is a holiday
>> season ;-)

You too :-)
