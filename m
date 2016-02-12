From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] gitk: update German translation
Date: Fri, 12 Feb 2016 20:17:31 +0100
Message-ID: <CAN0XMOKdCP1yGgmktMGtd0Pwr3rc=h-B9YYot23Ybe-HmkVi7w@mail.gmail.com>
References: <1455302439-9290-1-git-send-email-ralf.thielow@gmail.com>
	<CAGZ79kY8aSD-T-pcqeBBA-Rv9FwSeqAT2k2+OSyEsiPcF-AWOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Christian Stimming <stimming@tuhh.de>,
	Paul Mackerras <paulus@samba.org>,
	Phillip Sz <phillip.szelat@gmail.com>,
	=?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:17:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUJDl-0006Rh-4f
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 20:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbcBLTRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 14:17:33 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:36043 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750707AbcBLTRc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 14:17:32 -0500
Received: by mail-lf0-f45.google.com with SMTP id 78so57681865lfy.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2P0Oo8ME0NoZ/GsLYFkhRsLHZ7s/t54w9APzzbwQCZQ=;
        b=J0EkGHPIoJdk1Gyxz9uPBcy6MZJiP0gcga/ILxFf3snDxFTTtbSS2GBMHT1dwz0pb/
         7iNIkj2Auyjp11YYlOgGY6NUat0LHYTJI/w3oqjiZO0KIt1nV7vox5wU5ex/wqqbc5F3
         4mqMYqfOXWPMdQGNUTTtCuj2mmtm3lsr/AtSXqnOS/UCzunZJ4gZ3bnNbAj1PKbU5cha
         Qyhimy+CFya05Vr+VtGTKM8nUbjJv+juqmL/QDw60tps834oEQKmYkBxChJqDnXMNIG8
         x3Kb4rYrdnVrlMt6lw7q0WnD38nEqTwUYtZDrqJXqokhkM3vEeK/HFen1FBE5SNM+dLp
         vM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2P0Oo8ME0NoZ/GsLYFkhRsLHZ7s/t54w9APzzbwQCZQ=;
        b=LkhWFmycgu65nPCIFr9RybviqzoCOelCwVZGdV6eFP55AwEAdI9ppn80o0YXKGvmm3
         q3PWEwLv/4Q96GHyW/jebnGc6BC7hbJpimj5OF886W+FfYEn2R2KIb902NyuLTKdQb+C
         V/eauetE9Oo1O9jxDWVMzFRTGSU98cpkQpSoCn37f468X7yZxsfZwx3z9jOSzcbX7sP4
         QXLfxYQkZdF8HQKbGIH+nGGgiHEoleI9s5upLkPNLTurCh1u5HiLFCSiCSpL1w7w+k03
         Wr0gcCANSNcP3y+mWtLApwQ9GpMTQZ0i/7FjyA0f3lo1MhOHoqN/QPKlAst+HBIemmmZ
         xX3w==
X-Gm-Message-State: AG10YOTM/OpMhBztnWBQNffqJsvqnqdF9evBJa7QFq4CO+vcysKMGq/+LRN8uDeLzz7Z/XlOyvMdlVqpRpzWLA==
X-Received: by 10.25.10.200 with SMTP id 191mr1473290lfk.116.1455304651040;
 Fri, 12 Feb 2016 11:17:31 -0800 (PST)
Received: by 10.25.30.209 with HTTP; Fri, 12 Feb 2016 11:17:30 -0800 (PST)
In-Reply-To: <CAGZ79kY8aSD-T-pcqeBBA-Rv9FwSeqAT2k2+OSyEsiPcF-AWOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286072>

2016-02-12 19:56 GMT+01:00 Stefan Beller <sbeller@google.com>:
> 2016-02-12 10:40 GMT-08:00 Ralf Thielow <ralf.thielow@gmail.com>:
>>  #: gitk:324
>>  msgid "Error parsing revisions:"
>>  msgstr "Fehler beim Laden der Versionen:"
>
> "Laden" (loading) is not the most correct translation for parsing,
> but maybe good for the user. What about one of "analysieren, (zer)gliedern,
> parsen, bestimmen" ?
>

This message comes from a function named "parseviewrevs", so I guess the
function tries to parse the revs gitk wants to present the user.
So I think "Laden der Versionen" is OK for this kinda low-level POV.

Thanks
