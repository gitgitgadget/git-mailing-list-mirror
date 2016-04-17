From: bin wu <idevcod@gmail.com>
Subject: Re: Where can I find the MD5 or SHA1 of git preview client.
Date: Sun, 17 Apr 2016 11:34:15 +0800
Message-ID: <CAM8n_hsD9UC2vnzXN39UWs1u1FDNpvUYqbhydsb-4hiQ4dLNiA@mail.gmail.com>
References: <CAM8n_hso=ZGa9Mwz4fYuqFz7bGN2gAtCx2CLxVv+onC9ozRTaw@mail.gmail.com>
	<B8796C21280A4977A9AF3E400C58FDFE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 05:35:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ardU9-0007fo-Hi
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 05:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbcDQDeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2016 23:34:17 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35394 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDQDeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 23:34:16 -0400
Received: by mail-yw0-f196.google.com with SMTP id v81so850723ywa.2
        for <git@vger.kernel.org>; Sat, 16 Apr 2016 20:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=fu5oVcSlni0geGa0jJcgAxXwC8o6RyyGYwgKsb8vro8=;
        b=StEcn+Al4IJgl3g+BFoHuVsHzFxlrnZJQFUDIyP0waYJSGkLriTxY9kH9i7dA+xoTp
         vHPDtfRu0dpEtvx6OcAYCzgwt7Ue5q65AxrOfYzqCqr3HyXVtQtZ/jj0Wa+QWE/vBOFp
         95cmAbVWfMhfUXcF9hO8CQT4zu5U/nYuBYx4hVDmC1Vv8HNbALmwe3XMDtWAFW+WkU4U
         D/XS9sg2FBvRsRbAWPQLx+hkeOpo39FyQnI1tE8aUap4wuhDxArEPh2aP23lsrVcKmWK
         8xMvYipp/kHEVpGkAvIarSlR/CI3XALAvj8J0xC8XbuYxM5DIsv6KjOuN9i7wtJsphJN
         E94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=fu5oVcSlni0geGa0jJcgAxXwC8o6RyyGYwgKsb8vro8=;
        b=UFvUqvuVkqYeaxSt15RQKl3kaXT39L4OEO7smOv+9MJdq5FkZg6T6jCevClMSAUoFe
         PRyeP9KAlf2BXNz71eltf3DmKnXGRY5sdLva6mY9LNCeODpxT1wljJF2AttuuDhFq5oV
         Nqp0k/xToD50GQyW18cFjxEhu21FMu+n7DsFaELVxi5V0xhxp0l/IyaV2l+Oh7iQnjjB
         LNWQa2veOCczxglmrgrXT+rowHl5ciG0TKl8rBz6DIhZbuou/nOwwkmqgobNy3SNeu1W
         BrQRN6eCvcTuEGLawix3IPU7DWkqTNnELwyRjk09Wrrth2TllJKTzcCGOECuKPxuzTVT
         DG8g==
X-Gm-Message-State: AOPr4FWgrDZbM284Xn/aAvpDHsbnaTjeKyjksADFLbHlczmo8P6GJeALeGRPnoqJmQSWZz8XT9Mg9eukOMqK2w==
X-Received: by 10.13.204.144 with SMTP id o138mr18211254ywd.192.1460864055803;
 Sat, 16 Apr 2016 20:34:15 -0700 (PDT)
X-Google-Sender-Delegation: flztmz@gmail.com
Received: by 10.37.77.67 with HTTP; Sat, 16 Apr 2016 20:34:15 -0700 (PDT)
In-Reply-To: <B8796C21280A4977A9AF3E400C58FDFE@PhilipOakley>
X-Google-Sender-Auth: u7GSfBTcdScN621tnJIyhLGZq-k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291741>

Thanks a lot! It's my version!
There is still a question.Why not just post the the MD5 and SHA1 on
the download page?

2016-04-16 23:19 GMT+08:00 Philip Oakley <philipoakley@iee.org>:
> From: "bin wu" <idevcod@gmail.com>
>>
>> Hi,
>>   When I download git client from https://git-scm.com/download/win ,
>> I want to check the MD5 and SHA1 after finished downloading. But I can
>> not find them. Where can I find them?
>>
>> BR.
>> --
>
> Try
> http://article.gmane.org/gmane.comp.version-control.git/290684/match=announce
>
> If that isn't your version, try searching the list for other announcements.
> --
> Philip
