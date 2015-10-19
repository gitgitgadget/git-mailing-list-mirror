From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GIT PULL] l10n updates for 2.6 maint branch
Date: Sun, 18 Oct 2015 23:37:59 -0700
Message-ID: <xmqqmvvf9xdk.fsf@gitster.mtv.corp.google.com>
References: <CANYiYbHj5+X+FDsG9mcS5zY=4yRd4CHBe5im7u4oeXFDBj5euQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 08:38:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo459-0003Ey-Va
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 08:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbbJSGiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 02:38:02 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36660 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbbJSGiB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 02:38:01 -0400
Received: by pacfv9 with SMTP id fv9so85504308pac.3
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 23:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4u/wE9iYbZ6tors82vutbb8PziMgmH29oA4C95AIab4=;
        b=E2SUnvlJvnlRXnfndXvpNyjdem8HLhclSObeitxsphpOwuFjF5Ju+LrmzSN+3tNEVY
         no2xggRXP914ON4KiXSLSOctbe+TmnUuy+2mWywSISLJkJLVy6OtLe7FA3Fcr/aTfaiz
         8f+iN61xlhjvkDNKDF88WqhvDjhjPTi6LgYTLGzHwBAldO9y5/dfo9j0CMi2jVl3DiKg
         gRSGCPftaE32TqkPOyAbWXM6pZ/Xv7165adLTcGfDJNi8yHan5/nDTZNFam2m41a7r8t
         Ry98MLA4JPRQaVzZO8K6MXhiCS4piDUsuiKNgY05ClhC1XHVG/mwBY+LHSBdReEN7mDs
         rp1w==
X-Received: by 10.68.243.99 with SMTP id wx3mr32642750pbc.33.1445236680849;
        Sun, 18 Oct 2015 23:38:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id of1sm34194284pbc.11.2015.10.18.23.37.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 23:38:00 -0700 (PDT)
In-Reply-To: <CANYiYbHj5+X+FDsG9mcS5zY=4yRd4CHBe5im7u4oeXFDBj5euQ@mail.gmail.com>
	(Jiang Xin's message of "Sat, 17 Oct 2015 20:24:14 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279831>

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> Please pull the following into the maint branch.  It includes l10n
> updates in Russian which missed the update window for 2.6.
>
> The following changes since commit 8d530c4d64ffcc853889f7b385f554d53db375ed:
>
>   Git 2.6-rc3 (2015-09-21 13:26:13 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po maint
>
> for you to fetch changes up to 82aa9b751fe96c5e55c36819aedea3d47e98bb57:
>
>   l10n: ru.po: update Russian translation (2015-09-30 18:01:23 +0300)
>
> ----------------------------------------------------------------
> Dimitriy Ryazantcev (1):
>       l10n: ru.po: update Russian translation
>
>  po/ru.po | 3550 ++++++++++++++++++++++++++++++++++----------------------------
>  1 file changed, 1967 insertions(+), 1583 deletions(-)

Thanks, pulled directly to 'maint'.
