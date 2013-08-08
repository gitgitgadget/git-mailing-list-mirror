From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 8 Aug 2013 23:35:08 +0530
Message-ID: <CALkWK0=qfDo4gYp5b+ENWnxJKZO-9hiuN6xAF-O3odu6Y8uAGQ@mail.gmail.com>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
 <vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Damien Robert <damien.olivier.robert+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 20:06:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Ub6-0004yZ-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563Ab3HHSFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 14:05:49 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:45943 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab3HHSFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 14:05:49 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so2461122ief.12
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Cjiwp8mc9C3PM5jCAbe/IZskgQOas7rOPnUxucOCTBw=;
        b=h6npJVTkqE23aM6FatCIHsTtAFkpdFq7r7gNIWvE954eVsOP9GAH7UWtLewOqmnwyZ
         evJqWAUgL9+Sj3S3vDCztWrTo1yBULNHZDVzxkNHjPQ2F5MhUqd8UpiiCVrvDScWitko
         3KOurlR2MHCEWncn5D58Q38CWgQxWumd82/SfbkpJfBKtQZ6RajiPkrRZW/k7QpwzDiZ
         mJgmfqT3vfh0UZ6pCM52kIwdI9QnQ7YfiTjR7dk10xu7AKnDfRrGFHwgl32qBy81Y6hd
         iuRp9pQ7iJbBVMV8Ti+2LJkq1Mr6zAq5iUXWQYEREdOUL9ivmLU9vLGNJx3JL3gplKeL
         aE0w==
X-Received: by 10.50.73.74 with SMTP id j10mr51063igv.50.1375985148832; Thu,
 08 Aug 2013 11:05:48 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 8 Aug 2013 11:05:08 -0700 (PDT)
In-Reply-To: <ku0lqj$qvs$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231913>

Damien Robert wrote:
> If I may chime in as a user

By all means. Do not feel inhibited to state your problems because you
are a "user": we are all users; we eventually became contributors
because we found certain things that needed fixing, and fixed them
little by little.
