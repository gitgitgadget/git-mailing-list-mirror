From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 00/10] transport-helper: updates
Date: Thu, 31 Oct 2013 12:30:03 -0600
Message-ID: <CAMP44s2dtGdLy=yhNva126nbzoHyeKA_AOY0xNZu-Qyq4zKf3A@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
	<BBA75EFD-E68A-4E7F-A886-8878650D58A8@quendi.de>
	<xmqq4n7x8g6e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:30:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbx0V-0004i5-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754927Ab3JaSaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:30:05 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:40592 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754Ab3JaSaE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:30:04 -0400
Received: by mail-la0-f51.google.com with SMTP id ea20so2656085lab.10
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Pn2X8ZwgQLAn4Lb5Rs26+9PKigNQho3XWoTONZtuJa0=;
        b=w8W6bWcSKmj3qzAExRD1QBO2btUjWhGZZ7KAXiYjq1sbjto8oM5r/XJw3pospvuZkZ
         cg98kPDPL7ET0vEuvOUNGqhsaBAjp85HIHoYX/sBO8XOSGsusRITceDu4Qu/TefG96vY
         U3H56CGT4BurX7X4OHMsbiXM7pMTL06Kr8OC7LVqg6DwuM0nXizQVkAfVyfDGswTRNFA
         CacfA6Na78+yUMWuXbIoCGS1JvV7xdBqi53hiJCdzwhqycUuxfD0Q03BtjGv5NdC2/El
         z6YNhpFoL/rCyyxme3Ihx/1OZXV18NmFPP+CWc52WN1k+R856RAkDfFpk3pV2HnXpR9D
         SsHQ==
X-Received: by 10.112.210.136 with SMTP id mu8mr3200085lbc.25.1383244203057;
 Thu, 31 Oct 2013 11:30:03 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 11:30:03 -0700 (PDT)
In-Reply-To: <xmqq4n7x8g6e.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237147>

On Thu, Oct 31, 2013 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Max Horn <max@quendi.de> writes:

>> In other words: Would be really nice to see these applied!
>
> The series is sitting on the 'pu' branch, and I think there were
> some "fixup" suggestions during the review, so it may need to be
> rerolled before advancing to 'next'.

The suggestions are applied, as you can see in the diff.

-- 
Felipe Contreras
