From: Nathan Gray <n8gray@n8gray.org>
Subject: Re: Newbie grief
Date: Thu, 3 May 2012 20:13:01 -0700
Message-ID: <CA+7g9Jxp859st6SrViizwOMrU9vsnmfy6P64SK9y_-ZEzEB6Mw@mail.gmail.com>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org>
	<4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org>
	<4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com>
	<87obq5ggpu.fsf@an-dro.info.enstb.org>
	<7vehr1dl2z.fsf@alter.siamese.dyndns.org>
	<4FA307C5.102@palm.com>
	<4FA3090D.5080406@palm.com>
	<4FA32A6A.4070007@blizzard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Illia Bobyr <ibobyr@blizzard.com>
X-From: git-owner@vger.kernel.org Fri May 04 05:13:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ8xc-00071h-Gx
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 05:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158Ab2EDDNK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 23:13:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58611 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab2EDDND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 23:13:03 -0400
Received: by bkcji2 with SMTP id ji2so1876975bkc.19
        for <git@vger.kernel.org>; Thu, 03 May 2012 20:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=6LgemwUjLkLfgrqwKLgGN0Pk51SoocraWsAMsGXoxXU=;
        b=iuE33PU90fCzn6ToLNPktfVUEil/9Oh16C+DZpVwsa9kpcZ0qbJIyHKYkvqhQt9UDG
         pjysIMj7UFVkzj65eZMXkcmY6KQl2jP/yfnuqbeXF5yQdiCjb0DKQXBSpMNC561oNeRl
         7ex+KlUgTCWAysqcgUTcw6KdM+YmuJZknx+Ue10of1G/YAdRqfZw5P/aSb5cFs9ws/ff
         m5AK9JDxE+HEEXxoyO0S59OXI0NUzY5ISMltEmJf80blKWtOmseO5ROV+pMOkeejxCMh
         pnuPQnrfaARYGqHZvTg1i5EU3f/SaiqsFBHYJ2Xygp8+HAGnTaCtJ33Coal7KKOK7IEC
         /UAg==
Received: by 10.204.151.75 with SMTP id b11mr1486614bkw.1.1336101181506; Thu,
 03 May 2012 20:13:01 -0700 (PDT)
Received: by 10.205.42.6 with HTTP; Thu, 3 May 2012 20:13:01 -0700 (PDT)
X-Originating-IP: [66.75.229.176]
In-Reply-To: <4FA32A6A.4070007@blizzard.com>
X-Gm-Message-State: ALoCoQkw+OWq/ByZ6ljtqZzPjNQy/lIQc+QJcBKuZ0GY+UwspspS8Tkt5a5h+w80Z5ShJCkaxBHF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196983>

On Thu, May 3, 2012 at 6:01 PM, Illia Bobyr <ibobyr@blizzard.com> wrote=
:
>
> It is just a "non-fast forward" move of a branch tip. =A0This term
> describes what happens precisely :)
>
> It is true, that the term is non obvious to the new comers.
> One may google and get an explanation of the error pretty quickly.
> First hit for "git non fast forward error" gives an explanation from =
a
> new comer point of view for the simplest case.

I just led a team of reasonably bright people through a transition
from SVN to git.  Not one of them understood this message.  Every one
of them thought something was broken.  This is a very common
occurrence, so a short, simple message without jargon for this error
would be a big, big win.

Cheers,
-n8

--=20
HexaLex: A New Angle on Crossword Games for iPhone and iPod Touch
http://hexalex.com
On The App Store: http://bit.ly/8Mj1CU
On Facebook: http://bit.ly/9MIJiV
On Twitter: http://twitter.com/hexalexgame
http://n8gray.org
