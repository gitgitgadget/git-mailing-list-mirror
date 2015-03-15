From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH RFC 1/3] add: add new --exclude option to git add
Date: Mon, 16 Mar 2015 00:00:41 +0600
Message-ID: <CANCZXo5hi2C0oPe2TvY6MwaQJdaZhb1BgM+Sa_yi0nzaX6tT9g@mail.gmail.com>
References: <1426427399-22423-1-git-send-email-kuleshovmail@gmail.com>
	<5505C6BD.5000809@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	philipoakley@iee.org
X-From: git-owner@vger.kernel.org Sun Mar 15 19:00:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCqF-00058E-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbbCOSAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2015 14:00:42 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35057 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbCOSAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2015 14:00:42 -0400
Received: by oiag65 with SMTP id g65so21277870oia.2
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JgAWubKf/q+H6FFCIX6Yf9fhJ82VXXEBNgJvch+dJVY=;
        b=L1EHFciH9RPBwoJinIWE2wScY671Y7SESeTV1nte0bIc6no0ARjsv4sWvLEizOE6Hq
         k98NR5vxOqtLGXa39GmlnwM4ihyzXQD/ygKA9Rzt7k2NeipW1MmKJlXzR0wrIql5aD3R
         9rL5wqV7LevhYJIAIoLEzfGFAEIqNXej3PdbU7ON+CUf5GnPJ8tPoYgSwJB/nypZTj1x
         8UegrA3wkDk6YeFsDzvJK+GGofDAz437RrlszGFRP+hR1gbcrSYMzTgpaL3V8lbi2eJS
         0NDG5SV8gP+UQ6dg73z9nkbQOE6eU6iM0B15O/l7Toj0DHLBbH75ZZMbAzie92C+bJ+r
         DB9w==
X-Received: by 10.202.94.66 with SMTP id s63mr7000375oib.94.1426442441339;
 Sun, 15 Mar 2015 11:00:41 -0700 (PDT)
Received: by 10.182.197.10 with HTTP; Sun, 15 Mar 2015 11:00:41 -0700 (PDT)
In-Reply-To: <5505C6BD.5000809@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265504>

Hello All,

>> s /no/not/   ??

Thank you Philip.

2015-03-15 23:51 GMT+06:00 Torsten B=C3=B6gershausen <tboegi@web.de>:
> On 2015-03-15 14.49, Alexander Kuleshov wrote:
>
> Thanks for working on Git, some minor remarks/suggestions inline.
>> This patch introduces new --exclude option for the git add
>> command.
> "This patch" is redundant. Shorter may be:
> Introduce the --exclude option for git add
>
>>....
>>

Thank you Torsten for you feedback. I will make all fixes and resend pa=
tch.

One little question, how to better resend it? Just send v2 for the 1/3
or resend all with v2? Or maybe will be better to make one patch from
these 3 pathes?

Thank you.
