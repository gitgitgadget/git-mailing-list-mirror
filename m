From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: [PATCH] gitk: Remove tcl-format flag from a message that
 shouldn't have it
Date: Mon, 23 Feb 2015 15:30:37 -0700
Message-ID: <CAMMLpeQ0fyNm1pdF6iDBzh8q__g6H8Obgwg3mD680CydmCwfVw@mail.gmail.com>
References: <1421914779-30865-1-git-send-email-alexhenrie24@gmail.com>
 <CAMMLpeTvtzPuiQJVxAx-Ja4JsoUxih5azMaN7_RcLvajny6A6g@mail.gmail.com>
 <xmqqlhk6agxg.fsf@gitster.dls.corp.google.com> <CAMMLpeR6TkZxFQBVJukC3KgXM-cJkRY31m8OthHxMkaZzLqGjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>,
	Git mailing list <git@vger.kernel.org>,
	patthoyts@users.sourceforge.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 23:31:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQ1Wr-00035d-FM
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 23:31:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbbBWWa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 17:30:59 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:41761 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWWa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 17:30:59 -0500
Received: by labpv20 with SMTP id pv20so21966634lab.8
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cv2i2HOHetGyReAgwrKuc7OsVIxQIEydRiGUZ9PvzGw=;
        b=EgzpiWhlUkCqCQZW0uGQrjlyLOG4K1LUm7ce8GuZpsc9IBe1qrY+k+BC0GyfUzXYyA
         EzN3RxUd6x9XSDQoii8hgbslGWODsjMrxiYEP7lhNa325eII7o4WGsiKb3xcMa1N2qHF
         L2jJzE0vHpfmZAQ3GuDrnGRDstef4fM8dYPjixzfpZ3PtZMcY+t4vebCvKwfyzvqO2u/
         1E0w4XfEUdc2+9iW4DEFravB0bplI0A7DnGxEWJhKIrpz5/E3D6icKFXLfcIJwbwcQnQ
         L8s75MLBR3cJAVOqQS+O37iH7MnD/ZsF05qEf98JeoeH7JgQqFXm+Tzn6xF2jpLN4t/Q
         9dyA==
X-Received: by 10.112.219.135 with SMTP id po7mr11593357lbc.111.1424730657828;
 Mon, 23 Feb 2015 14:30:57 -0800 (PST)
Received: by 10.112.146.42 with HTTP; Mon, 23 Feb 2015 14:30:37 -0800 (PST)
In-Reply-To: <CAMMLpeR6TkZxFQBVJukC3KgXM-cJkRY31m8OthHxMkaZzLqGjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264302>

2015-02-16 16:27 GMT-07:00 Alex Henrie <alexhenrie24@gmail.com>:
> 2015-02-09 14:55 GMT-07:00 Junio C Hamano <gitster@pobox.com>:
>>
>> Alex Henrie <alexhenrie24@gmail.com> writes:
>>
>> > This is just a friendly reminder that this patch has been sitting in
>> > the mailing list archives for a couple of weeks, and it has not yet
>> > been accepted or commented on.
>>
>> I think that is because the message was not sent to the right
>> people, and also because the patch was made against a wrong project
>> ;-).
>>
>> I'll forward it to the gitk maintainer after digging it out of the
>> archive and tweaking it.  Thanks.
>>
>> Paul, comments?
>
> Another week and still no comments on either this patch or the gitk
> Catalan translation patch. Is Paul Mackerras still actively involved
> in the project?
>
> -Alex

Another week and still no response. If Paul is no longer maintaining
gitk, another maintainer should be appointed.

-Alex
