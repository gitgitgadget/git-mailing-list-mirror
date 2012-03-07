From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: I18N.pm is incompatible with perl < 5.8.3
Date: Wed, 7 Mar 2012 21:53:54 +0100
Message-ID: <CACBZZX5wHEigiYjn6ahmnXN3wd9sEyDnRV2EZiP+JSUCc182TQ@mail.gmail.com>
References: <4F2A8B78.6090902@statsbiblioteket.dk> <CACBZZX5YuN8vpmTiP_38Aa=c3KDqEHCKBX3DE2YKkeMCdR4GBg@mail.gmail.com>
 <4F575B16.9050801@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:54:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5NsL-0005Ye-B1
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 21:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945Ab2CGUyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 15:54:16 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64672 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab2CGUyP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 15:54:15 -0500
Received: by eaaq12 with SMTP id q12so2389019eaa.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2xYJR1s6V6tZQQAc0dvmpsGOdHwhU1quCGCC6LKQN4Q=;
        b=d9p7OVbdyRQpdRiDFYrfj8GsqH9+sgY+18Sgcu/tsh1Ypp9bPVwmEK7NKeUeKdEk6H
         rU46zkHyihYQa1M+66q1nvRWLPafp3JJqQ+0n/xEzyT7xtjjRcdFxxnbnXL4Wv228MiL
         d0UY8/NkBK/ShD9RXuWgWkxnJbeT6nnBvO3qN7vLKHib9ElvQ3a9u5axTo97tLPXIBe0
         lnPfew6aEtl8muPajKWDeo8aQvcEoO+sYiGmKitCrDVKMfjl9tWKgsNqz8E9Vd7OIZMl
         xrAErh8GQFCoDgQlYmhwrd6QLr3yyVASJ1Z1FzPenMRm2I0t/uAI5ns4LZE48feSLJwB
         5scQ==
Received: by 10.213.27.22 with SMTP id g22mr864959ebc.83.1331153654473; Wed,
 07 Mar 2012 12:54:14 -0800 (PST)
Received: by 10.213.2.147 with HTTP; Wed, 7 Mar 2012 12:53:54 -0800 (PST)
In-Reply-To: <4F575B16.9050801@statsbiblioteket.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192481>

On Wed, Mar 7, 2012 at 13:56, Tom G. Christensen
<tgc@statsbiblioteket.dk> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Thu, Feb 2, 2012 at 14:11, Tom G. Christensen
>> <tgc@statsbiblioteket.dk> wrote:
>>>
>>> Hello,
>>>
>>
>> Thanks Tom, I'll submit a patch for that.
>
>
> Nothing seems to have been submitted and both this issue and the issu=
e with
> missing NO_PERL_MAKEMAKER support still exists in 1.7.9.3.
>
> I think I've answered your question but please just ask if you need m=
ore
> information from me.

Sorry about that. I'll submit a patch this week or this weekend. That
NO_PERL_MAKEMAKER issue is also either fixed by now or I'll fix it.
