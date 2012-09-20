From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] Improve legibility of test_expect_code output
Date: Thu, 20 Sep 2012 01:48:20 +0100
Message-ID: <CAOkDyE95x0_ZVCsrsC8kJWdrzMo8b0nQ19N+QKXy64vQ4N6E+A@mail.gmail.com>
References: <1348094310-11214-1-git-send-email-git@adamspiers.org>
	<7vboh1eew2.fsf@alter.siamese.dyndns.org>
	<CAOkDyE-x5NeZX2tpp3C9Kkwb1kPniHptB9ERvtpx2XODufaW=A@mail.gmail.com>
	<7vy5k5cyzg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUwS-000205-E4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324Ab2ITAsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:48:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42904 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007Ab2ITAsW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:48:22 -0400
Received: by bkwj10 with SMTP id j10so850121bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 17:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=c9DXnN7L5JZQM5HHDmAkHKHARGz4kL6R24BJObijGr8=;
        b=B7fBpgh8B94OEzsXHkFi3gtJV6gKYs1DK0Czv1MO9Ns5mKWKLpOWF4WzduKYUOynWG
         ZxHSzrQfDqGDtW7/9HMM6nXW/chc0unW5kOwkywoX/UB8EbnOmY6mbFDJ80VgrZyunZU
         9g6fiA0CNvmZt7OHXLrdh6bbpQyLEZ+x4i8sLWAs4sNLSqOJassqfNLgHuhMOYKIclJJ
         SKiL9ierVQS6jJiBCplyae4Ul3kT+skUH02zkds9MAWiKybGnk+/K5JC+42dV9VmhWD2
         +EBe79nRwVGyOdHfYRYFhon22lxa58P6Gh+WSdF0kPIJHC7xltqImN0lrXcKU7HDwEHJ
         vvQw==
Received: by 10.204.152.207 with SMTP id h15mr87556bkw.5.1348102100950; Wed,
 19 Sep 2012 17:48:20 -0700 (PDT)
Received: by 10.205.81.80 with HTTP; Wed, 19 Sep 2012 17:48:20 -0700 (PDT)
In-Reply-To: <7vy5k5cyzg.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: W7f1h9F0CIgfLeMfCgw3eWtzRjU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206024>

On Thu, Sep 20, 2012 at 1:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> If it were "..., we wanted 128 from 'git foo bar'", then I would,
> but otherwise, not really.

That's fine by me.  Both are better than the status quo.
