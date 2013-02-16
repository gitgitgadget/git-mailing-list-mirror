From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/4] t7800: Update copyright notice
Date: Fri, 15 Feb 2013 22:35:17 -0800
Message-ID: <CAJDDKr7acMrki8r2KWfcjiwr+Naiq_GT53UOo0D42qecPF361g@mail.gmail.com>
References: <1360993666-81308-1-git-send-email-davvid@gmail.com>
	<1360993666-81308-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 07:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6bNA-0000Q6-Te
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 07:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3BPGfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 01:35:19 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:62073 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3BPGfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 01:35:18 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so1922724wib.3
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 22:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=vVshljaxO+wdTEFqkqHl75jI5+blAJg+zVp2pEtUSho=;
        b=rpHIbBjFmJUDvB20T1dAFKmpdJe7CPYw80a/peRBqmMZRZ5bRkvuKch1Ha66EimFoT
         +VhQic2+T9mmn6Dg3Uhwd1+ZaqFPbN4hHH5R4CtBn37Ey8RlSMDi8JtdyMOT7tsd4xUd
         jnf84Q1/1DCjzwqB9iJfgVQE2BLYRMl5T6cYsBHhMQ/L016lY3bNvObYvVdxxexfFkch
         rOeen+H9kuWc9S9JmKIs8c2IvWy6UXFy/wQUyVGZ5i65wv4P6ZvrGLh5LIMHxo3oymf4
         y0kNLP7s+G9R6f8EPViMY7qj4hZUQC76I2aw3mh8lNz0OUNAGhSbeLUy3C0XGB3mlCKE
         pkWA==
X-Received: by 10.194.92.65 with SMTP id ck1mr8348889wjb.54.1360996517388;
 Fri, 15 Feb 2013 22:35:17 -0800 (PST)
Received: by 10.194.76.2 with HTTP; Fri, 15 Feb 2013 22:35:17 -0800 (PST)
In-Reply-To: <1360993666-81308-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216376>

On Fri, Feb 15, 2013 at 9:47 PM, David Aguilar <davvid@gmail.com> wrote:
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
>  t/t7800-difftool.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index eb1d3f8..bb3158a 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  #
> -# Copyright (c) 2009, 2010 David Aguilar
> +# Copyright (c) 2009, 2010, 2012 David Aguilar

Oh boy, I'm still living in the past.
This should also include 2013.  It gets me every time! ;-)

I'll wait and see if there are other review comments before I resend.
-- 
David
