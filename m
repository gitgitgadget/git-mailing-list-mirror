From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: fix typos in comments.
Date: Sun, 6 May 2012 17:18:15 +0200
Message-ID: <CACBZZX7hUmEK5-7rpmZiDx4u5_aV_uiwijtzP5-jFNd4si-iQQ@mail.gmail.com>
References: <1336308300-4858-1-git-send-email-semtlenori@gmail.com>
 <CACBZZX4K5vh7CjJ6SqX-reuuNqse7koONC=1HcXCuY0vbXRpbQ@mail.gmail.com> <CAFT+Tg8fvVawnCFwmXfBep1b+uonEB7J3eA3wJDMVSRcaXHMAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: semtlenori@gmail.com
X-From: git-owner@vger.kernel.org Sun May 06 17:18:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR3EQ-0007Ey-5z
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 17:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016Ab2EFPSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 11:18:37 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33095 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab2EFPSh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 11:18:37 -0400
Received: by eekc41 with SMTP id c41so1204266eek.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wzu3OL7KdFwjww5B2kDqMo1UTj8KsiMU2yGkbaXxCkw=;
        b=ldf1S+kpjgBvrSaLVONMZ5DfpODqxfmJhp1+EbZlDU5NOY0xap9zAk06rNap6je8pf
         if+MsZvhGZt8lGwNiFrAsROSXU+NBCPOaoRJmUh1tDndAKK3TZuQVnxfeA8OtmKbnmHl
         9CcETDrEaWyR4Xy6nlhMrnL4r/g4YiTRkD15SipAb7PpKAHg9sJ+A14NrC/+n9TrdVlc
         k+ZInlY/cOhBtfB6RgIqnycDpCZgT6ml+FVaD19DczQpOij5r1okHV/jQIuat3kkOxa0
         qtyKggMkXOB1907WH2s40SSy+plY76pFHkgrNG0LcId/5DqtsboVyLmMTbSO7HHH5hKD
         s4QQ==
Received: by 10.14.127.5 with SMTP id c5mr35299eei.120.1336317515991; Sun, 06
 May 2012 08:18:35 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Sun, 6 May 2012 08:18:15 -0700 (PDT)
In-Reply-To: <CAFT+Tg8fvVawnCFwmXfBep1b+uonEB7J3eA3wJDMVSRcaXHMAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197195>

On Sun, May 6, 2012 at 3:40 PM, Yi, EungJun <semtlenori@gmail.com> wrote:
> You're right. I will send this patch to gawk developers.

If you're doing that anyway it would also be very useful to see if
they'd be willing to take the the rest of the patches we've
accumulated since we initially brought it into our tree. I.e. the ones
I showed in the shortlog I posted.
