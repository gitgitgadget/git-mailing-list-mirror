From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Sun, 1 Nov 2015 10:50:28 -0600
Message-ID: <CAOc6etY5Gh+njnWjtA3MYgnu+LCR-x75UCNOdRDw4+ReEbhVLQ@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
	<CAOc6etYCzBYpf+7p8p3=zQun7bYXYVc-codoUf5Abcq+hAz8cA@mail.gmail.com>
	<CAPig+cQ+-k_eAm+EMEHqAyQ1P-AjNXQwmyPKqm=fD3vZ1chTLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 17:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsvpx-00056f-Ic
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 17:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbbKAQu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 11:50:29 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33460 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbKAQu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 11:50:28 -0500
Received: by padhy1 with SMTP id hy1so116592982pad.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WPdvIDEWAidBgkgzrw/5QAgJ+DXk1era7b7CzHiCmKU=;
        b=i3FFUvDs4iIfUyTSNwnnPQ7jBVxeOxX9bRoD5I9p1JGvsuZmjqjSaUS5RVoB0MasV3
         vs9chSAxE8R7+WNFgSLLWQfyPEhFja8li8WBCUwkk112BrZ6/aJYCXJ41PV1x+7JrPUY
         BBoLj+2EkGj6u3LDD38dwpE+OjO/Ep2/RqxujBtPgNCta6txTmi34n3nAqF8EoVyWzBw
         MMsbdeufSoI3mePhO32U6C0tMTKBmvOxyTPCJBqIi/qTaKi3vu7PbuXlatw023Pf8rGV
         p1zPaBLAvNjpxKFHDMO8rokz7jKSt+HsMUfLsY4zwgNqb7tdRBwwYEuLGmH31myW6ggl
         yjwQ==
X-Received: by 10.67.14.42 with SMTP id fd10mr21896945pad.11.1446396628484;
 Sun, 01 Nov 2015 08:50:28 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Sun, 1 Nov 2015 08:50:28 -0800 (PST)
In-Reply-To: <CAPig+cQ+-k_eAm+EMEHqAyQ1P-AjNXQwmyPKqm=fD3vZ1chTLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280635>

On Sat, Oct 31, 2015 at 6:45 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Patches in 'next' are pretty much set in stone, and those in 'master'
> definitely are, but 'pu' is volatile, so just send the entire patch
> revised, tagged v2 (or v3, etc.), rather than sending a patch to fix
> what is in 'pu', and Junio will replace the previous version with the
> new one.
>

Will do!
