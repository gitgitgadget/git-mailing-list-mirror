From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Mon, 13 May 2013 23:47:31 -0500
Message-ID: <CAMP44s3D1qTaSWVgNWEDUp7FKK91RxhJozr1LKV6VK95rAQmzA@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 06:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc79G-0008CW-Fk
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab3ENErd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:47:33 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:35376 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab3ENErd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:47:33 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so85200lab.6
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=thu+09Jp9096Zx+sRaV8AAZ+QkT9LY19uFIE5ORzHjI=;
        b=Qps9FYwp1oIJPjy8W8JtZwwhxuV5/F3YAshaLqEjQQrf0gew2oLz0vlRaclMneHR70
         C2IFmSXxvglmnQ9vNjc1pw6irgZL58kfZz4FR6pBKSkil7DrRQhXHEKmj8si82oUbpvo
         wM+UQ/AwtCsL3JrPWbj9f3B6RGHVZE5J8FU+8qIpgTUbjQYI7hrQSYYktZnwNTcVH/fG
         mLn0dlJ+gwbDOC83u+YcYWqtcZS88Cu/Dyt3xxsL0H/OoervY/WPL7L10SchhA6ExQli
         jaZrnmyWjNZH7g6VapPZRhgoB26umdkzIy67XIv3oRyDIzQ2N3i1c7IV3n5w+tD3bF0b
         pyig==
X-Received: by 10.112.135.70 with SMTP id pq6mr14522630lbb.82.1368506851401;
 Mon, 13 May 2013 21:47:31 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 13 May 2013 21:47:31 -0700 (PDT)
In-Reply-To: <7vfvxql66j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224283>

On Mon, May 13, 2013 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Folks interested in working remote-hg, please try it out, so that we
> can have a polished one soon after 1.8.3 ships (I am not saying this
> round is not polished---I haven't even looked at the patches).
>
> And others, please spend time on testing the 1.8.3-rc2 to make sure
> what we are going to ship is free of embarrassing regressions.

If we want folks to test something, it should be the patches I
prepared for 'next' which I just sent.

Cheers.

-- 
Felipe Contreras
