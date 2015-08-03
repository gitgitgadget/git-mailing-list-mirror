From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Mon, 3 Aug 2015 22:49:49 +0200
Message-ID: <CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	<xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 22:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMMgF-0006T5-J4
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 22:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbbHCUtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 16:49:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38153 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbbHCUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 16:49:50 -0400
Received: by wibxm9 with SMTP id xm9so130310676wib.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GnYp/aSy3C0aTXoud2IE75qgomy6agibngE1FYuQECU=;
        b=Cg2w+uSaS2pbOmNHflMp+7Di/8Ymp13aVoRw/BJ5sQkNVdasdCfLZvbAb0t6ubfoG4
         4FV9nmSm09ZIJQqbS2RAhPvX4mUJ0W2MyUx7UI/MBSs9x978hiwxFcKjgvOy6B00e0y8
         HDjRMk1ghzIrQrpc1WgaimfI+ekM4onWdqZzv9IAfKAJwhBQ3Q+7Rx99xy+T9JzGvDKG
         WEMjOKOhReUQkdAxmmyeDvpYME/kbwkVWYuLkyzFACVJT70CpBrMHy2EVN3xQ7hrFmH/
         ilBiTtzwOcoJstb1aIiPAzCnIegW/vVOKg1YmZuJ65igiGbxY/mmgI5cBsP3Ii20GGfD
         zaJw==
X-Received: by 10.180.91.134 with SMTP id ce6mr265331wib.60.1438634989570;
 Mon, 03 Aug 2015 13:49:49 -0700 (PDT)
Received: by 10.27.47.137 with HTTP; Mon, 3 Aug 2015 13:49:49 -0700 (PDT)
In-Reply-To: <xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275198>

On Mon, Aug 3, 2015 at 10:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks; it seems that the review section is rather thin.  No new and
> interesting changes worth reviewing in the entire month of July?

Of course there are, but I can only put in a few hours, and that goes
into the links-section. The newsletter's coverage is only as good as
the coverage that gets contributed. Christian has by far been the most
active contributor on that side, and as he is unavailable these days,
those parts are scarce.

I hope we can attract more contributors in the future, so the weight
of this doesn't lie too much on his shoulders. Perhaps we should send
out the draft earlier next time, and beckon for more contributions
from the list.

We could also add a call-for-help at the bottom of the respective
section, asking people who are trawling the mailing list to
contribute.
