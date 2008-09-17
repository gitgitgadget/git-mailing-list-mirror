From: "Pekka Kaitaniemi" <pekka.kaitaniemi@gmail.com>
Subject: Re: GIT presentation
Date: Wed, 17 Sep 2008 14:25:47 +0200
Message-ID: <588bb7d90809170525k6e8f5935o3dd94c7eef4faf13@mail.gmail.com>
References: <4d8e3fd30809170208t3730cde1t4cbcdb1e609d6be6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 14:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfw7z-0008SZ-1T
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 14:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbYIQMZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 08:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbYIQMZx
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 08:25:53 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:35147 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYIQMZv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 08:25:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3161276rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OOjUAsxneOByrxSZOwpWZOJvx8ba5HJ6pUwlOk0CHt4=;
        b=oF9vHQri5OZUNofDERl8bUu4ssNVqSQYUaX09IY2874m1XKlKRJH3kC5R6hV7dPlYn
         Om6FyUuD/QTgxglAeA1be+n1OrlILuXnEfj6y7bt32K6fHvMXIsLSIvbzxLniCalKaaN
         tGTELwOaQDwQmBRogWvYP4yVgrZzQNI7QJiQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=VG7J1yc8na6Nl1HIDveQZyGhgNhWqT+aJnKIQ9GrFF/ipDMn0aQzDbjen6RFucud86
         dDJJSY7TNpzgu1sVt0EzI8OX4t6nrpdYaHBD7vIQfBZl6OAayUK7ys14IHLTlKwxCuNy
         fYPOf2X8AvcDWYyHsvVlnOK4s7FRQfybHW0lk=
Received: by 10.141.29.14 with SMTP id g14mr6465309rvj.241.1221654347888;
        Wed, 17 Sep 2008 05:25:47 -0700 (PDT)
Received: by 10.141.194.18 with HTTP; Wed, 17 Sep 2008 05:25:47 -0700 (PDT)
In-Reply-To: <4d8e3fd30809170208t3730cde1t4cbcdb1e609d6be6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96100>

Hi,

On Wed, Sep 17, 2008 at 11:08 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> Hi all,
> some friend part of a LUG asked me to do a quick
> presentation/introduction to GIT
> to a group of people  probably completely unaware of it.

I did a short talk in our research group meeting about Git. The
audience consisted of particle physicists who were previously familiar
with basic CVS usage. Some of these people now actually use Git to
manage their analysis software project.

> Is there any available presentation that I can as a base for my presentation?

My slides are available in both PDF and LaTeX source formats. The URL
of the PDF file is:
http://www.cs.helsinki.fi/u/kaitanie/gittalk.pdf
And the LaTeX source can be found and cloned/forked from GitHub:
http://github.com/kaitanie/gittalk

If you are willing to use LaTeX and Beamer macro package you are free
to use my slides as a basis for your own.

> I'm of course, more then willing to publish the work a let everybody
> to use/modify it.

If you choose to take my slides and improve them I would like to
see/merge them back to my presentation source tree so patches are, as
always, welcome...

-- Pekka

> Thanks.
>
> Ciao,
> --
> Paolo
> http://paolo.ciarrocchi.googlepages.com/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
