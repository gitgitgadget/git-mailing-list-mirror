From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: branch.<name>.pushremote not working with push.default simple or upstream
Date: Fri, 7 Jun 2013 23:03:56 +0530
Message-ID: <CALkWK0=FnZUBXMJjSKgrbunDn3TtME-1tw++B5FimJx5=K_1qQ@mail.gmail.com>
References: <20130607124146.GF28668@sociomantic.com> <CALkWK0miONv_O67SHcfJoXq1x7xPvKu6uefg+TiPGbF-1WJ-bg@mail.gmail.com>
 <7v8v2lvs5s.fsf@alter.siamese.dyndns.org> <20130607161402.GH28668@sociomantic.com>
 <CALkWK0=v2vF7oGG3yUAXfaGdodCrkbvmQA+z9hMcoeMUFGFgsg@mail.gmail.com> <20130607170752.GI28668@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Leandro Lucarella <leandro.lucarella@sociomantic.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 19:34:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul0Yi-0005fe-PU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 19:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924Ab3FGReh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 13:34:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:36803 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3FGReg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 13:34:36 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so11137666iec.19
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=YxvF2RSbZMNh4W3l26Ts6Mj1JCRT1aik0qHaXEwl5ik=;
        b=wyuRln5nQUBcm3i3Tt4jHUH3AsIsf5KJc24f379gTJa+ZqGYIBKJ83PNLto/GUkrsb
         KYAub75IBBs4OFJu0ZeOUspr/qb6cdjz7J40ISGhk7jFzZs8jTJZQ/Q8zsmLWd3ONr3e
         JRtY4hfErUCb8SiDHvDxdiG/H/X39GmEmPOideCrp0GyRAQAG+eeqzuI5bBNZQQa3phT
         Z3d9dBsjWYK2vQYoIZNSwbEIJsmrfsIgkYrCY/vWd+Tl+BAx7A2SvIc4tZmU9FsGKU2+
         9avvlRFxBciiOZ03XxE1gi7AjFC+vBgZaPs69nxLUUks81pSaldO1w86SiKzKkwEswQI
         Ss8g==
X-Received: by 10.50.107.6 with SMTP id gy6mr1900188igb.57.1370626476247; Fri,
 07 Jun 2013 10:34:36 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 10:33:56 -0700 (PDT)
In-Reply-To: <20130607170752.GI28668@sociomantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226654>

Leandro Lucarella wrote:
> I might try to just switch to current, I feel more comfortable with
> simple because I feel is safer to explicitly set the upstream branch,
> but is true that most of the time is not necessary.

Be more experimental!  Use the lesser-known features, and tell us
about breakages: that's how you can help git improve :)
