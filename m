From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Promoting Git developers
Date: Tue, 17 Mar 2015 21:08:57 +0100
Message-ID: <CAP8UFD0NPLF1o8h8hqBfiG76qF1HU9DOCfHqi5-z9DkrV+aEvw@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	<xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
	<xmqqvbi1sy4h.fsf@gitster.dls.corp.google.com>
	<003001d05f71$81845160$848cf420$@nexbridge.com>
	<CAP8UFD08xoJ2H8XgfDbPfHddX9YFpFgbrY+PZ5Tphuot7JwGvw@mail.gmail.com>
	<87a8zdguxp.fsf@fencepost.gnu.org>
	<CAGZ79kbOkgA2pfsh3Av-iuHe4qRz2XWDu6Onm9QTXJRtAoABXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 21:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXxnU-00089f-GX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 21:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbbCQUI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 16:08:59 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35045 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbbCQUI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 16:08:57 -0400
Received: by igcau2 with SMTP id au2so44874619igc.0
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1veaq9DshBAHhou19kR6j40Iv5hFLRJVe3NAtDFQXk4=;
        b=IP/DQ9VqINfp8ahU6ib4sK081hb/Q6A3yV0yknW60IKHYRYPLsWxlPc8DcsJR1mln4
         XX198tYyCd34NRBldSlgZaHNa2VjyLZO2Am5EF1Q/40y2quKYXit9KCCWYP7r5VsvHfu
         wz0wO2mtd0oBzdPcaqhBnAw8Xcg0HyFz5P+30hs2bGd8gD9RVkSnztEF7uxlbLIepkOX
         7dypg8QOzxmiWrSP++eFc7Jflf7nTOLT35jb9L1s6lz3TKBfrfWJ5rbNy5f21I07w2AC
         JoVNjEX4fWx09k9xFvPDipZtj3vU6jVlCgLj5xVLTW02uAsCkAx0RPiP3qEsu3pTUAiP
         3mUg==
X-Received: by 10.50.253.12 with SMTP id zw12mr991755igc.24.1426622937224;
 Tue, 17 Mar 2015 13:08:57 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Tue, 17 Mar 2015 13:08:57 -0700 (PDT)
In-Reply-To: <CAGZ79kbOkgA2pfsh3Av-iuHe4qRz2XWDu6Onm9QTXJRtAoABXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265660>

On Mon, Mar 16, 2015 at 6:06 PM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Mar 16, 2015 at 2:20 AM, David Kastrup <dak@gnu.org> wrote:
>>
>> "Git Annotate"?
>
> "Git Praise" as opposed to blame?
> "Git Who" as a pun on the subcommand structure which doesn't always
> follows grammar?

Yeah these suggestions above are nice, thanks for them, but "Git Rev News"
also look a bit like "git rev-list" and "git rev-parse" which are plumbing Git
commands, so it gives a somewhat "hardcore" look to the news letter which
I like.

Thanks,
Christian.
