From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: repository of handy git aliases?
Date: Mon, 8 Aug 2011 20:22:04 +1000
Message-ID: <CAH3AnrqEfu1jeCo55bJxLDK8845PsLoZtoT0iWkMUtt1+K9X-w@mail.gmail.com>
References: <CAH3AnrpSeWytri-bHEi_9qkAKG1fjL0pVuYFOrrmZumJ6dv_wg@mail.gmail.com>
	<CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 12:22:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqMyK-0006CM-1V
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 12:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab1HHKWI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 06:22:08 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42204 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1HHKWF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 06:22:05 -0400
Received: by vxi9 with SMTP id 9so2330550vxi.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 03:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=L86wZ3RZ380aKUYuCghYUT33yyCFczi1kSiQacmdWRM=;
        b=g4FuDWG5+XZIzmRGcUNm1Z/nAXIIaTvThIMxu2AS6d4t6sgCvFr6OJx8WvSXVEKmA8
         h8souWbdRFSYEqfiXLvjkGcQAjKA1PywokEOGBghXg5czMez7+AC/3tAA19dsp5KB3pG
         O8GQqz7bBJW97c7lln2HVrEeR4/qeKo4cNjck=
Received: by 10.52.66.226 with SMTP id i2mr5458463vdt.268.1312798924498; Mon,
 08 Aug 2011 03:22:04 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Mon, 8 Aug 2011 03:22:04 -0700 (PDT)
In-Reply-To: <CANQwDwfwvaYQt+ck8ky0obyeAa--Wwtdme3UC4vNMFkSiBMq9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178951>

On Mon, Aug 8, 2011 at 7:45 PM, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
> On 8/8/11, Jon Seymour <jon.seymour@gmail.com> wrote:
>> I was wondering if there is any interest in establishing a wiki page
>> or gist repository of git aliases that people find useful?
>
> https://git.wiki.kernel.org/index.php/Aliases
>

Ah, thanks. I added this link

        Aliases - for list of handy tools implemented as git aliases.

to:

       https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and=
_tools#See_also

since that is where I expected to find a link when I looked. (Of
course, I should have searched, but I didn't!)

jon.
