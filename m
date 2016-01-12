From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Mon, 11 Jan 2016 22:34:50 -0600
Message-ID: <CAOc6etYKmnPWH8jgeA+Cu_2=TPSWO0Nbfm3Yy-ceN6HwEdNhwg@mail.gmail.com>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 05:34:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIqfX-0006tY-4Q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 05:34:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761643AbcALEev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 23:34:51 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35154 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761069AbcALEeu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 23:34:50 -0500
Received: by mail-pf0-f177.google.com with SMTP id 65so56017315pff.2
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 20:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H4eeTs/3Nas+7c1nJN/1gRqwpkM/2+NnSYyt6/Q1KM0=;
        b=GrO+jEVGsDaVY0rAZtNX3bPzHFxj/mszfu1tB7YS0rTWkku5A5Qx6m2a25DY1cdzSn
         YtVsK1AuZN9FrLIAOCZ1MBtddmUdZgGDHhFvP36oCsYEVULtKIlIGKZFY1lRiZ1NaZqQ
         Yrsgvboct6f28JvCQbmMTJBfez5LYu3fBiKTB1pTF5A7X8TEDDF3e6No9YM0mwITytxc
         eI2ALuL3czwbO55FdiAqjNd8xVwrm0VB93j1AttC7b+zGCmOBtBSOyI4nxoXFRlcoFhH
         mceCaKHxmWU1Mfn44GwyFStVG5P1/EuyAB47oVWpi8YfAeNmDgWfy+ogSQMoV6MzS9HT
         35AQ==
X-Received: by 10.98.9.147 with SMTP id 19mr26201027pfj.163.1452573290379;
 Mon, 11 Jan 2016 20:34:50 -0800 (PST)
Received: by 10.66.126.167 with HTTP; Mon, 11 Jan 2016 20:34:50 -0800 (PST)
In-Reply-To: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283766>

Sup, Junio!

On Mon, Jan 11, 2016 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>
.
.
.
> * ec/annotate-deleted (2015-11-20) 1 commit
>  - annotate: skip checking working tree if a revision is provided
>
>  Usability fix for annotate-specific "<file> <rev>" syntax with deleted
>  files.
>
>  Waiting for review.
>
>

Dude, this is waiting for you to decide if it's OK to go down this
path or not _but_ it's not that important anyway so feel free to drop
it so no more brain CPU time is spent on it when writing 'What's
cooking'. It's ok.

Cheers!
