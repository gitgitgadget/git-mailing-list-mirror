From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 19:24:55 -0500
Message-ID: <CAMP44s0PYreS7g8FfUW-3+9xY56-yiusKRcmUKHnZc4kDwXF-A@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
	<CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
	<7vwqqy7v8g.fsf@alter.siamese.dyndns.org>
	<CAMP44s17aD_ryeGWQazTcJ3nrhe6C9TLhKHhrUnys=Yj_ATa0A@mail.gmail.com>
	<7vzjvu6faq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3c1vdCn43S=nSzfj=znZ9L_7jH9-+EOY0+SZNnSBTVbw@mail.gmail.com>
	<7vfvxm6biv.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 02:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud8Tm-0001Hc-AO
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 02:25:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246Ab3EQAY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 20:24:58 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:35434 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab3EQAY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 20:24:57 -0400
Received: by mail-la0-f46.google.com with SMTP id fk20so3647034lab.19
        for <git@vger.kernel.org>; Thu, 16 May 2013 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=i19VzoDJSKO+J9emNSiAAGJR+W5nFxLIUu+jFep3URI=;
        b=gj2Pck7ETJ/E9M3sa/6UpfldL8n1ul/hE4N0C7wFMF0Axud55K75HPXjQXudMiMwdb
         hr9aQugP3qsdw2m0HieZ7qr6ir+yElZrWZOsZRdlWLhGm1fgknUWQ56zLUjciYxvdfMn
         qaz0biovExeFwWQ7nq9c75uGeXhheB4gUHrWzaY0sE0bOLLniAaNZf68g5QjhalGbSfZ
         1YjhUU+lpL4Eb/vdPzxo8JLynEZj/89fpvZV7tp4Bd58IR+BLUwwMZj4YgwaV7zXAoSb
         Swg6XATxdq3xcSA1Q4UrNr45x5AEfLQldtx16N3n3JmZ0Tk4wdGt75yj86dCjkTqMFjB
         /t9Q==
X-Received: by 10.112.145.72 with SMTP id ss8mr21343505lbb.12.1368750295884;
 Thu, 16 May 2013 17:24:55 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 17:24:55 -0700 (PDT)
In-Reply-To: <CAMP44s2QcFStPtE8cSbH7jWvUOUVRSgGNYNVoDN6exRdW6xNYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224644>

On Thu, May 16, 2013 at 6:54 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> There are 535 instances where parenthesis are not aligned. Do you
> still think aligning open parenthesis is the "style of the project"?
>
> Please. You are rejecting this patch on a whim, and nothing more.

And FTR. I shouldn't need to waste my time demonstrating this obvious
fact to you, you should already know that the project doesn't follow
this style, and if you don't know for sure, you shouldn't act as if
you do. And even if you were correct, and this was the style of the
project, you should not reject patches based on unstated guidelines.

Would you think it's fair for you to go to jail for breaking a "law"
that is not written anywhere?

-- 
Felipe Contreras
