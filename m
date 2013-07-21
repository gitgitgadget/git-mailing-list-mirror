From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3 0/3] Switch German translation to G+E
Date: Sun, 21 Jul 2013 21:53:32 +0800
Message-ID: <CANYiYbEkstQ1xr0zHfBgHU2qDDfvEuj_o+4QHhG1FWMP4J=-og@mail.gmail.com>
References: <1374040279-4828-1-git-send-email-ralf.thielow@gmail.com>
	<1374078276-3510-1-git-send-email-ralf.thielow@gmail.com>
	<87txjs6pdl.fsf@linux-k42r.v.cablecom.net>
	<7vr4ev1wyr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <tr@thomasrast.ch>,
	Ralf Thielow <ralf.thielow@gmail.com>, jk@jk.gs,
	stimming@tuhh.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 21 15:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0u5C-00084J-AB
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jul 2013 15:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491Ab3GUNxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jul 2013 09:53:34 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:40769 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab3GUNxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jul 2013 09:53:33 -0400
Received: by mail-we0-f173.google.com with SMTP id x55so737496wes.32
        for <git@vger.kernel.org>; Sun, 21 Jul 2013 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VR63VX7jDa2ZH7Q62jJ3wGT5soFEzXX8meNNcwq/8io=;
        b=nzwSdRbZMbl4xE6MwdWfad+iaL0JAgIIgxlEXh05Rf+N/tVuxGi11DdaE4TBmFyWxC
         FJmc4fnED5MPdp/1Z6rKnsPEbU8vUoxKDjQ1TskFWGgmvSnB5t/+MVzh8qb78G+nGz2I
         /Ipr3RNmBf23RRqcqyz1L/I4Td3e8A6ov0t0yIxxqqLVGc+Kw/S0KdvK9F7yNpVyn+C/
         Mt/Vkq1jeLSKKXbZzAaFo5acl4pc5l4E7iVm46ggvrPb+oO4qLSDJWhUo08lkYYecB8Q
         NN82sdlsxXXc5gZArcQsrZ6oHUjAUZDgkPfi3QfM24BJEr/q7nv+uNds3P/UGL5NeBKi
         Xf8w==
X-Received: by 10.180.75.80 with SMTP id a16mr10492260wiw.3.1374414812293;
 Sun, 21 Jul 2013 06:53:32 -0700 (PDT)
Received: by 10.194.176.129 with HTTP; Sun, 21 Jul 2013 06:53:32 -0700 (PDT)
In-Reply-To: <7vr4ev1wyr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230936>

2013/7/19 Junio C Hamano <gitster@pobox.com>:
> Thomas Rast <tr@thomasrast.ch> writes:
>
>> Ralf Thielow <ralf.thielow@gmail.com> writes:
>>
>>> This is a resend of v3 because at least one patch was
>>> damaged last time for whatever reason.
>>>
>>> Ralf Thielow (3):
>>>   l10n: de.po: switch from pure German to German+English (part 1)
>>>   l10n: de.po: switch from pure German to German+English (part 2)
>>>   l10n: de.po: switch from pure German to German+English (part 3)
>>
>> Thanks, this one applied cleanly.
>>
>> Acked-by: Thomas Rast <trast@inf.ethz.ch>
>
> Let's make sure our i18n coordinator is aware of this effort.
>

First round of l10n for git 1.8.4 will begin right after rc0, and according
to the calendar[1], it may start tomorrow. Ralf please send pull request
for this as usual.

[1]: https://www.google.com/calendar/embed?src=jfgbl2mrlipp4pb6ieih0qr3so@group.calendar.google.com&ctz=America/Los_Angeles&gsessionid=OK

-- 
Jiang Xin
