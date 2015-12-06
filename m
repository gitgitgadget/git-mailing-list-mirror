From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2015, #02; Fri, 4)
Date: Sun, 6 Dec 2015 10:12:18 -0600
Message-ID: <CAOc6etZBnB6EKiD3xD-zp-QJz20ueQzdtdJMSZz6wOH_HFZXxw@mail.gmail.com>
References: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 17:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5c21-0003kK-LH
	for gcvg-git-2@plane.gmane.org; Sun, 06 Dec 2015 17:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbbLFQSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2015 11:18:48 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33165 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbbLFQSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2015 11:18:47 -0500
Received: by pfnn128 with SMTP id n128so51476583pfn.0
        for <git@vger.kernel.org>; Sun, 06 Dec 2015 08:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NTBqYxZXSWMGDPVnLjLalbZWKqTFKMIMfQxXNZps+iE=;
        b=IzN/1M8UMWM55qX35igaiWuAxl1BmcbNutaWLlAwY/l4ZWbwGhJR96HVuweHUT5L0L
         2Hpgr6kMp22jrB0gERXHFATBUI54W7SNbDUyftOu0Wz41nyrvwvvM/vltFIga2lpTbC0
         Anl+tjD8Vvln0erE+Yh2UYqKYfjqDLADCD0FDoPA+yIVOhrw6dTMsECz6Fw2Plt4Rjq2
         qx9HUq8oKyat8nOdEoC7Dzdniq60mm1Nl1v2U42vRzo4Q6FOxtVcTgNfbcaqiaS5l+M9
         oNzGXtTsJeyDMfQVXRHYQT7SUaSt7l/M9zZQUm2/VwKGJ/aEsYuncUcKgTIMwLkkdkJs
         CZBQ==
X-Received: by 10.98.16.133 with SMTP id 5mr36386395pfq.150.1449418338285;
 Sun, 06 Dec 2015 08:12:18 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sun, 6 Dec 2015 08:12:18 -0800 (PST)
In-Reply-To: <xmqqa8pprej5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282055>

Hi, Junio, Jeff!

On Fri, Dec 4, 2015 at 5:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * ec/annotate-deleted (2015-11-20) 1 commit
>  - annotate: skip checking working tree if a revision is provided
>
>  Usability fix for annotate-specific "<file> <rev>" syntax with deleted
>  files.
>
>  Waiting for review.

Is there something I have to do about it?

And, another thing, I had sent the fifth version of my patch about
progress for blame where I took care of all the comments hat Junio
stated before and I got no comments since. I hoped that patch would be
listed sometime but I didn't see it in this what's cooking or the
previous one. Maybe it's bellow your radar? Is there something else I
can to do about it? ($gmane/281677)

Thanks in advance!
