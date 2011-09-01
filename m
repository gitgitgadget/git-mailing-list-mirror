From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2 v2] (short) documentation for the testgit remote helper
Date: Thu, 1 Sep 2011 18:59:19 +0200
Message-ID: <CAGdFq_iqNxeRhQUfY0BVBNWqDq01i9MJ_2STC0MjiF0p=rrBGg@mail.gmail.com>
References: <vpqd3fk1cq5.fsf@bauges.imag.fr> <1314895778-17482-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314895778-17482-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:00:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzAca-0007xp-4T
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429Ab1IARAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:00:00 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:57015 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab1IAQ77 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:59:59 -0400
Received: by pzk37 with SMTP id 37so3260088pzk.1
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=abZbwVZYjKbuQnZd24Jz1F55CMZpOPU+s2JNcXtJp9k=;
        b=ms7Jl3NiAwUpWzyZSTshV8A/DP38FvuFnOM5h+IXjyHvABUSgJZo7J3RahI9ZdiD5Q
         FUc8S0KUdFNZHBTybgUJYtYzJbNMdF9Km+W0yjLGx2kmQ8qlbBJ7lX2zXwgnMSNtMwLj
         eNBlHbHTcygrbQp/2IKuU19ujq5c5JpYClt0Q=
Received: by 10.68.59.105 with SMTP id y9mr413213pbq.26.1314896399070; Thu, 01
 Sep 2011 09:59:59 -0700 (PDT)
Received: by 10.68.43.9 with HTTP; Thu, 1 Sep 2011 09:59:19 -0700 (PDT)
In-Reply-To: <1314895778-17482-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180549>

Heya,

On Thu, Sep 1, 2011 at 18:49, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> While it's not a command meant to be used by actual users (hence, not
> mentionned in git(1)), this command is a very precious help for
> remote-helpers authors.
>
> The best place for such technical doc is the source code, but users may
> not find it without a link in a manpage.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
