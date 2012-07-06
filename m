From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [RFC] l10n: de.po: translate 29 new messages
Date: Fri, 6 Jul 2012 20:58:21 +0200
Message-ID: <CAN0XMO+wz-2EGcX+KoLQLYDsG7Kz1T7YujxdJTUo1Yvqx=A4tg@mail.gmail.com>
References: <1341335086-6767-1-git-send-email-ralf.thielow@gmail.com>
	<2021839.rMjHRWft8I@cs-pc>
	<CAN0XMO+R3+JiuHSZ0O46py2WbXVh8D2Z+f7t_xofsN6ZrFwnQQ@mail.gmail.com>
	<m28vf0aqb8.fsf@igel.home>
	<CAN0XMOJF8+iJqyiqvBxEHOVGMB17rPnO9Pnu29LY1fMDBopKGw@mail.gmail.com>
	<4FF72C70.1010202@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	jk@jk.gs, worldhello.net@gmail.com, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 06 20:58:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnDjZ-0003n9-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 20:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757751Ab2GFS6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 14:58:24 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61555 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab2GFS6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 14:58:23 -0400
Received: by wgbdr13 with SMTP id dr13so9581515wgb.1
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AwrdMs0SmnA6uKrAGfbBXS8kGAfcrVvrcoj3o88Xx+4=;
        b=DX1mZqO/b4VhudYVIZ6Lb/UEsV3XwvFfPevbG7YPCQ3QrOOfTbsdg1VU7uFoGU2x2v
         hpBQUBESH1eowKhJ7g1v8KwARM6lG6YChwDhwgKgVfrL5rzFNW6MyCyF4S89GNpviOk6
         nIS9ATwSitIs9eHZ9FBOyVCWBruN6vr9C6TD/d/i0qlw8s7IdmhDpBUR5n2shcWzTDlp
         O831HTI+28jvRFpyNilcazxmMKvM8xycs7yDfvdl1sVG94Fu4lrhq5u0HrGdJzYKOmWZ
         htW+yjIATDx7ZJjOQ+S41cHzeiEruokDxdpGT74WrZEwz2APghKEemEL6x/VBb8hbx8V
         Xlww==
Received: by 10.180.106.97 with SMTP id gt1mr9972519wib.5.1341601101913; Fri,
 06 Jul 2012 11:58:21 -0700 (PDT)
Received: by 10.194.7.8 with HTTP; Fri, 6 Jul 2012 11:58:21 -0700 (PDT)
In-Reply-To: <4FF72C70.1010202@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201137>

On Fri, Jul 6, 2012 at 8:20 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Ralf Thielow venit, vidit, dixit 05.07.2012 20:16:
>>>>> Is "rebase" = "Neuaufbau"? My last thought on this wording was "rebase" =
>>>>> "Umpflanzen".
>>>
>>> "Basisumbau"?
>>>
>>
>> I have added both suggestions to the glossary that they don't get lost when
>> we discuss about non-optimal and/or missing parts within the glossary.
>
> Not the base is being reconstructed, but what's on top of it. So,
> "Basiswechsel" would be more appropriate.
>

I agree with you. There is no question what it means, but what are
the best german words for it.

> But: "Umpflanzen" is really a great term which stays within the context
> of trees, roots and branches. Strictly speaking, "Umpflanzen" refers to
> something you do at the root level. The corresponding action for
> branches would be "Umpfropfen". I think that also conveys the effort
> that is sometimes necessary ;)

"Neuaufbau": it contains the concept of rebase
"Umpflanzen": it contains the concept of rebase
"Umpfropfen": Actually, this word isn't familiar to me. It's a bit
unusual, isn't it?
(but it might contains the concept of rebase)

The whole point is that the user needs to know what it actually meant
in git-context.
If a user read "sie pflanzen gerade um" or "sie pfropfen gerade um", I
don't think that
this is the best solution. I haven't said that "sie bauen gerade neu
auf" is the optimal one,
for me it's better, though.

We really need to discuss (and thats indeed also an issue on other
translation teams), which
git (or SCM) related words we shouldn't translate at all.

Thanks,
Ralf
