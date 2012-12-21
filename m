From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v7 0/7] coloring test output after traffic signal
Date: Fri, 21 Dec 2012 10:00:09 +0000
Message-ID: <CAOkDyE8ac0jCutt-hP-p-Bk+PqVda0diXkOANrPbMpT5XTy2GA@mail.gmail.com>
References: <CAOkDyE9tDYRYzojzNnjWsT7UygxMAurHqLSDGA66_LMPD2Wmnw@mail.gmail.com>
	<1356059558-23479-1-git-send-email-gitster@pobox.com>
	<20121221081521.GA22193@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 11:00:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlzP4-0004ck-Ud
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 11:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab2LUKAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 05:00:13 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:61414 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab2LUKAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 05:00:11 -0500
Received: by mail-we0-f180.google.com with SMTP id t57so2023307wey.25
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 02:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=X7Bp9BU1k1bA2KH74J+SkwQnZHoYKHUF+eXUAEOMVyo=;
        b=kWYCDFv7qLes7Q7WznaU1H44NZ2s0AcsK+76sxN9DuEbfw9ZnyFalqssbAHVLzHe73
         xNxSUcpdzhlzIbBgWMzULL8d4qlLT+4BB2lTN3Qrg3bTFFYg+0wBVPSnSPZO40bpXDov
         3XEarndssba62PH1HTOzfaTcFIW4JT0qj1o76x1xzgPRFxThHRpV7psUl4y0NO7BPN72
         nCwOHd4HCI/YuE00dJ6mG9t08GaMgrDTlPyZYgX6K8MdSWSKJlRE5J+Ygo7JgWE4uMZF
         a+R1TREqkKJU1+YdM8NXUngUDWy/yQfIQYoC/5KD+7//ff60KqwmNadQHRkQVAsf9d1E
         xo9A==
Received: by 10.180.101.99 with SMTP id ff3mr21996682wib.21.1356084009594;
 Fri, 21 Dec 2012 02:00:09 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 21 Dec 2012 02:00:09 -0800 (PST)
In-Reply-To: <20121221081521.GA22193@sigill.intra.peff.net>
X-Google-Sender-Auth: pLBKk9jcRb6C5vtDj5IywUBZwko
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211962>

On Fri, Dec 21, 2012 at 8:15 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Dec 20, 2012 at 07:12:31PM -0800, Junio C Hamano wrote:
>> To conclude the bikeshedding discussion we had today, here is what I
>> queued by squashing stuff into relevant patches, so that people can
>> eyeball the result for the last time.

Great, thanks a lot Junio.

> Thanks, this looks OK to me.

To me too.

> And thank you, Adam, for your patience. Seven iterations of color
> bikeshedding is more than should be asked of anyone. :)

;-)
