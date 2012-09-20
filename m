From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Thu, 20 Sep 2012 19:05:00 +0100
Message-ID: <CAOkDyE-fi6y5kc9hP9q48kWN0PNmU2CSgWid0EwA9RwQd5fSiA@mail.gmail.com>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
	<7vboh1eew2.fsf@alter.siamese.dyndns.org>
	<CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
	<7vtxusbpub.fsf@alter.siamese.dyndns.org>
	<CAOkDyE9hvBz5wYbj+q=oYTz7zWnP2E9dqtKZ-V=6jBW-FomfbQ@mail.gmail.com>
	<7vipb8bnbo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:05:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEl7j-0008Bj-80
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 20:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab2ITSFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 14:05:04 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43848 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab2ITSFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 14:05:02 -0400
Received: by bkuw11 with SMTP id w11so394731bku.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=kYBNA/PqW6+Vt08xMMXPPo0RJtcbnQ01NdVlqjRWCUk=;
        b=DxHlBZIcncrwUOpNf5MfI5I3JfhtjYVEtXP6KBMeA+wI3wSGRN2MukdIXSK3KEOGTJ
         +BnRpw0SXNil6nsxBGzu1HsrQb9TWRMke8ZnRbNo9f74v0XrVjiV6+tYmtjqYXX5DmhO
         +SU4w5yvM3/m5xdx1FAtJyrUAFU/Hp6OitNGX1mLsRXG2sIpBUGk7YT1XcpuMp0Ef+IA
         6W8wOvaxXDIejXnjky+mMFN2nQzFVEu0Ux0HBV92lhRjDVuD9GnX94YRNHnj97dM90Y1
         sKZqSLGPy0Y8qqBxSg5lnB4HDoR90WTi+DwVaAZch1KgwSg9BZ/wBdibNXGExuPWgYNQ
         GwuQ==
Received: by 10.204.152.207 with SMTP id h15mr1133132bkw.5.1348164300635; Thu,
 20 Sep 2012 11:05:00 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Thu, 20 Sep 2012 11:05:00 -0700 (PDT)
In-Reply-To: <7vipb8bnbo.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: -ys9_3U_FUjBhm8osZ1ng1Hzu9I
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206064>

On Thu, Sep 20, 2012 at 6:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>> On Thu, Sep 20, 2012 at 5:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Do you want this queued on top of your other series, or as an
>>> independent change?
>>
>> Independent please.
>
> With a sign-off?

Yep.
