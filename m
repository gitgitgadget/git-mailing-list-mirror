From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Publishing "filtered branch repositories" - workflow / recommendations?
Date: Fri, 6 Dec 2013 14:40:15 -0500
Message-ID: <CACPiFCJ5hCPvRHB1knvMocN0XdHfSMpbZnqjf7yHAT4mMOSfzw@mail.gmail.com>
References: <CACPiFCJPq0fqOQrJD-8CHH405Xw61ZDynqqfN+_aZb3ZBgV2VA@mail.gmail.com>
 <52A0D199.1010403@web.de> <CACPiFCKHprB_oO_eXMYkey_CGbT7WOn5VDDjBdHbLRzcDpHnZw@mail.gmail.com>
 <52A0D9F5.3030101@web.de> <CACPiFCJ3mkOj=E+siideBpPfgS1tSicVQ46KqPK+Tha0DbkZHw@mail.gmail.com>
 <52A18F69.70002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 06 20:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp1GU-0000lm-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 20:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952Ab3LFTki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 14:40:38 -0500
Received: from mail-ve0-f172.google.com ([209.85.128.172]:49680 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3LFTkh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 14:40:37 -0500
Received: by mail-ve0-f172.google.com with SMTP id jw12so1300266veb.17
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 11:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=J97jKXoXL/SpDuskZwjHLSN0SsnqZnkGIlP45hXDQvw=;
        b=NwaFxUqcJewVjK+/Wx0Nf3B+F29FxbUwmHmDZhADmA9CA8CTz1HL7FyHHTv56lHkZz
         rUlBGP/wJ/m2NM6GrzhvQCe5F/IXYK14XGpDAnVgXaMOkNAzzbAB2vaNi6tRms3EGKeC
         sJBFQmF5x/h/ZWBQokjoLqlXGg+FUvVKoB6ocEcJZ8jw68iVbZ3JToaGSaDrK2jRsD9n
         VJ0vm6bZsKp9j4L6RBIeXvwTOaAMF4jRkie8KRKpJvesaZ9wNmICPcxh6AosXDlQyNSX
         ysqtm/ipyoolMrJExKDEXfFD4s1XKWGJmcnAHSTrQSmUZzc56glbBbB5NXrmlSklQPFo
         QMsg==
X-Received: by 10.58.46.18 with SMTP id r18mr2905192vem.4.1386358836669; Fri,
 06 Dec 2013 11:40:36 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Fri, 6 Dec 2013 11:40:15 -0800 (PST)
In-Reply-To: <52A18F69.70002@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238947>

On Fri, Dec 6, 2013 at 3:48 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Right you are, we need tutorials for the most prominent use cases.

In the meantime, are there any hints? Emails on this list showing a
current "smart" workflow? Blog posts? Notes on a wiki?

>> Early git was very pedantic, and over time it learned some DWIMery.
>> You're giving me hope that similar smarts might have grown in around
>> submodule support ...
>
> That's what we are aiming at :-)

That is fantastic! Thank you.



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
