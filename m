From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 4 Feb 2009 16:12:59 +0200
Message-ID: <94a0d4530902040612v30df6ea8ifcf3e3244cf1c027@mail.gmail.com>
References: <1233432317.26364.5.camel@wren>
	 <94a0d4530902032339p365df42i2b8f235430a68fd5@mail.gmail.com>
	 <1233748114.7594.0.camel@wren> <49898E2A.7070005@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jesse van den Kieboom <jesse@icecrew.nl>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUiWN-0002IW-Kf
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbZBDONG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbZBDONE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:13:04 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:38878 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbZBDONC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 09:13:02 -0500
Received: by ewy14 with SMTP id 14so3325856ewy.13
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 06:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Du7lmhYbKjbuI6ILg+N9fntxbed6pH55Q9lp/EDMZeU=;
        b=I/JC0m2jHbLx0VWjkm/VPEYTf9xM0+fXDPtqnHODqBq5U03nhrXU+KNbuzatBDAu7x
         4FayZ/iOE7NnqX0zdRy9uGRs60aHFWXpr0fpjCEdVsOCMJkt7MHmRQPYRLRnEcwkIzHP
         BxDQlInGShpFwoLbD54vdC0RCzBbYRGcR1/WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZW+NvcGwQM7uP+hBGy9nJPL+4X/FTiFYPrXxexw3NBmrUoxl2AlojON08zeDpTxvFQ
         gxjwZl6uY9IFhXsd1vQacsYBFnTCbf3X48y43SQyPkbTPaU9O7eYRfrCukFgo0dXhG36
         XebfD34F8FLgU0Zrk2O7LeqpttLW9i3/JF0UA=
Received: by 10.86.95.20 with SMTP id s20mr1133118fgb.40.1233756779979; Wed, 
	04 Feb 2009 06:12:59 -0800 (PST)
In-Reply-To: <49898E2A.7070005@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108362>

On Wed, Feb 4, 2009 at 2:46 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Jesse van den Kieboom venit, vidit, dixit 04.02.2009 12:48:
>> Op woensdag 04-02-2009 om 09:39 uur [tijdzone +0200], schreef Felipe
>> Contreras:
>>> On Sat, Jan 31, 2009 at 10:05 PM, Jesse van den Kieboom
>>> <jesse@icecrew.nl> wrote:
>>>> Hi,
>>>>
>>>> I have been developing a gui application for git for gtk+/GNOME based on
>>>> GitX (which in turn is based on gitk). I feel that it's reaching the
>>>> point where it might potentially be useful for other people to use. It
>>>> currently features:
>>>>
>>>> - Loading large repositories very fast
>>>> - Show/browse repository history
>>>> - Show highlighted revision diff
>>>> - Browse file tree of a revision and export by drag and drop
>>>> - Search in the revision history on subject, author or hash
>>>> - Switch between history view of branches easily
>>>> - Commit view providing per hunk stage/unstage and commit
>>>>
>>>> The project is currently hosted on github:
>>>> http://github.com/jessevdk/gitg
>>>>
>>>> clone: git://github.com/jessevdk/gitg.git
>>>>
>>>> Please let me know what you think,
>>> And the obligatory screenshots?
>>
>> The screenshots are on the website
>
> Grin ;) At least I'm not the only one who didn't how to navigate the
> github page...
>
> In fact, reading the top line there in the first place would have made
> me hopeful that this is a unifying rather than splitting project. So, my
> best wishes (I'll try and compile)!

I have several projects there, but I only use github for the vcs
stuff, I never actually clicked the 'wiki' tab before.

Anyway, I tried gitg and the history view looks very nice (like GitX),
definitely much better than Giggle, but unfortunately it's still not
usable for me (gitk addict). Keep up the good work :)

-- 
Felipe Contreras
