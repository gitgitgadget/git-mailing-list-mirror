From: Sebastien Douche <sdouche@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Tue, 8 May 2012 16:01:43 +0200
Message-ID: <CAAGHeXEu6c9Sn7u4W5nk7cOE+Ao3zjyF4peHGaXe-BoUoJEisA@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:02:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkzm-0004F1-8h
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 16:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab2EHOCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 10:02:25 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33939 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab2EHOCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 10:02:24 -0400
Received: by bkcji2 with SMTP id ji2so4642192bkc.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 07:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zJgnaO/zo39AqWVi1wrz/G0Hy4FvcsG37jgJo9vJUpg=;
        b=cU8XSUI1r10g3u1uLwYIxPx4javlIvRYAETddqUljjxjeB6rGMyvcTViT9+vJwljxl
         hI8kfbsKjbutup1VXMzW6B6WcNBnt/9AY5f0mGhCIBlnuyZ9W6G0EQKvUx3eZ9BHsSn9
         m07DxF+LZYZ6G2JnbzKsDRmtLaJ4RZ/Xh6mLrJYa5IuSNk1OFmc3A66d191tozwb+l9e
         i4Bo4UZ//VzthYl/dw7EoG0QZ1UxfRbsSztBSyGSpCVLFrck1T+0xQAKX7xaqK0Zk6/0
         MgfE3x13pMzpwquyqDoskTf838wXgs2Amkjap61WbwcWbYvxRmIxcsVPaRSQytFpKkO9
         uSoQ==
Received: by 10.205.130.6 with SMTP id hk6mr7118917bkc.64.1336485743463; Tue,
 08 May 2012 07:02:23 -0700 (PDT)
Received: by 10.204.185.204 with HTTP; Tue, 8 May 2012 07:01:43 -0700 (PDT)
In-Reply-To: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197366>

On Sat, May 5, 2012 at 3:04 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Proposal:
>
> Avoid the terms 'cache' and 'index' in favor of 'stage'.

+1000. An anecdote: many attendees said to me "I didn't understand
until you explained it that way". Now I use always the term "stage" in
my training (and banned the term index). Far better.


-- 
Sebastien Douche <sdouche@gmail.com>
Twitter: @sdouche / G+: +sdouche
