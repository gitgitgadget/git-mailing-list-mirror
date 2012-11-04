From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce diff.submodule
Date: Sun, 4 Nov 2012 23:28:17 +0530
Message-ID: <CALkWK0kdMbiTUYcSmY1OZOt6fjLTesi9y3S2LZvagjhu-0fn4g@mail.gmail.com>
References: <1351766630-4837-1-git-send-email-artagnon@gmail.com> <5092E535.3010701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 18:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV4U0-0002lg-0h
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 18:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453Ab2KDR6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 12:58:39 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:40966 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab2KDR6i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 12:58:38 -0500
Received: by mail-we0-f174.google.com with SMTP id t9so2306212wey.19
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 09:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5kLRtk5WLub2HClYqmy29rol63IeJJsEUsE+vJMFmNA=;
        b=Gcbriz99sWuLZSos/jc1tPWkB0LeiErTlRVQWMRMm3fWyjlWoJ+u8v665/HQV0uX4r
         4EzzPJ/iceVaKcEMUtRNsBM5RiTc/r3Z6+WDcNIotJWFkt1v4NgKs0h8oBNZqvpkJqVI
         uxS5Hdi6+wrBwh4ACQhvwbm15fSKU/zxAU60NSL+CfUw2Ifm1WFDx1xaHqo1x66rae2m
         7MmAzNKKf7z/3TmE9i3YzXEaadsWpLdb+mg7p7TGA+RGQTVZ03xIMtSArJHLa8ojC3y8
         CA83Ke2K7kokc2IoHkpFb73XsJ4Ck2ui9Xki2EKIse3jViMhoYKG3aUHZxrgHdVd3VxD
         zO8g==
Received: by 10.216.200.163 with SMTP id z35mr2395524wen.53.1352051917328;
 Sun, 04 Nov 2012 09:58:37 -0800 (PST)
Received: by 10.217.69.201 with HTTP; Sun, 4 Nov 2012 09:58:17 -0800 (PST)
In-Reply-To: <5092E535.3010701@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209037>

Jens Lehmann wrote:
> Am 01.11.2012 11:43, schrieb Ramkumar Ramachandra:
>> Hi,
>>
>> v1 is here:
>> http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
>>
>> I've fixed the issues pointed out in the review by Jens.
>
> Thanks, looking good to me.

Peff, can we pick this up?

Ram
