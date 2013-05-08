From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (May 2013, #02; Mon, 6)
Date: Wed, 8 May 2013 12:45:51 +0530
Message-ID: <CALkWK0=W50eKSQ61HwpohGYQu5At12CL1dBMrMD8BD6pSTPcpA@mail.gmail.com>
References: <7vip2vmg0k.fsf@alter.siamese.dyndns.org> <CAMP44s3+6Yaau8c=RYF8B_Quvnk9X34Umyjtnne=E_MKeYEd9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 09:16:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZycA-0001yt-2v
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 09:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab3EHHQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 03:16:33 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:40806 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab3EHHQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 03:16:32 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so2584464iec.35
        for <git@vger.kernel.org>; Wed, 08 May 2013 00:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ONlK1W1UR8BTL3lmyS7KHR665JDaSdXuzAyGZqMwkOY=;
        b=r678UbtC0xX1lsFd6O5sw84GR5xT3b0bGwz168qt6DwGGwAN06Kkm+NHJEZ42rQdU7
         p0Mi/vdn39Lm+zD7D1FbNCsT2pCgAD0ZXQAtbvVCu/hC3dr30nP50+/cX7VUfS8wk8PW
         Wv1QlC6vkQf90iaymCYFZWLbXOsHMGJKgbD/JpgxP4culv+V2WbeD8Ld/uU97BOF8iZe
         XioOuWrZwJ+9oNEEVhTYlV5FJ0GZqYcYXEUxz63TYTWLFwDWSs08mEF1J8tugLlRb74f
         54uREXWg6YDfYC513p3hT89ib0vnBrOenN3riqC+FKdoEcM8Ldv0V+rt/+MDsRhN+s9x
         x7eg==
X-Received: by 10.50.66.140 with SMTP id f12mr1987868igt.63.1367997391677;
 Wed, 08 May 2013 00:16:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 8 May 2013 00:15:51 -0700 (PDT)
In-Reply-To: <CAMP44s3+6Yaau8c=RYF8B_Quvnk9X34Umyjtnne=E_MKeYEd9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223645>

Felipe Contreras wrote:
> This series has cleanups and features that are good as they are.
> Ramkumar said he was going to resend his cleanup series, but he
> didn't. I'll try to gather all the patches and split them into
> cleanups, and features.

Thanks for picking up the pieces.  I was out of town these last few days.
