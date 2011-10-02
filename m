From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 2 Oct 2011 16:40:14 -0700
Message-ID: <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
References: <CAE1pOi3Eg88i+1s+CcW3+W0WNZ-NYUQb1EV55oh+g1Od78AByQ@mail.gmail.com>
	<CAE1pOi3OEFg7-OeQM0fvD69gf-5oPQ239CGy9nN0Waas8EM3Bg@mail.gmail.com>
	<CAMOZ1BvHKTPPmfB7Jx+y4OeRv-uwjmQkscXaRr-vEEy30G_Kdw@mail.gmail.com>
	<CAE1pOi0b2w8t53U7PSvVwVxZF9O0HTyfCR4vy+-baBjqCDeNJA@mail.gmail.com>
	<CAMOZ1BtOkwVbC3RyJVQb7K1DRMnJf3_omn7zrkzoE48Ayu7HBg@mail.gmail.com>
	<CAE1pOi0jZT_HCEV8UDzEOQeuCcDeqxoKGUEk3bJm=O2eJSHfkg@mail.gmail.com>
	<CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 01:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAVdt-0004E0-5f
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 01:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734Ab1JBXkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Oct 2011 19:40:17 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:47059 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407Ab1JBXkP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 19:40:15 -0400
Received: by qyk7 with SMTP id 7so3147419qyk.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 16:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ejIq2W3Pf2Sse6zdknbh6FTSYvst4P03DmtWMuYEKeg=;
        b=Z9rhFw4uW0lZJmZq8U6kETduap8iN6gDjc9aJ9/uTU0YzgBRYXuYKZi8XXGB7Pjesb
         r65FELjUbLN/6muSutZeHYl86I95Wa8+iKQ3aVOjiFmUmcmq60UD5WgfapERZ2pARM2r
         qhIYV2dyj7IgHQOfgkAn2YnjNNQu2s9NnkYjA=
Received: by 10.229.63.20 with SMTP id z20mr1094489qch.201.1317598814904; Sun,
 02 Oct 2011 16:40:14 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Sun, 2 Oct 2011 16:40:14 -0700 (PDT)
In-Reply-To: <4E889813.8070205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182614>

On 2 October 2011 09:57, Robin Rosenberg <robin.rosenberg@gmail.com> wr=
ote:
> Hilco Wijbenga skrev 2011-08-22 22.10:
>>
>> [...] I just wish there was at least an option to
>> keep the timestamp (and possibly other such things). Even Subversion
>> can do that... ;-) After all, not everybody uses C& =C2=A0make.
>>
> What tools do you use that need the benefits from retaining timestamp=
s? The
> only
> one I can think of is clearmake, but then that tool goes with another=
 SCM.
> Eclipse,
> for example, will be just as confused by timestamps that travel backw=
ards in
> time, as
> make is.

Why would timestamps travel back in time? They simply would not change.

Anyway, we're not really talking about the same thing. If there's an
update (i.e. git pull or something similar) then changing the
timestamp to something (anything) newer is the right thing to do. In
fact, it would be painful (as you already alluded to) if this were not
the case.

That's however not the scenario that I'm talking about. I'm talking abo=
ut doing

git checkout branch
git checkout master

or

git stash
git stash pop

In both cases all files (or at least all affected files, in case of
git stash) get the current time as their timestamp instead of the
timestamp they had before. This is forcing (completely unnecessary)
rebuilds. *Nothing* has changed but I have to do a complete rebuild
(well, I suppose I could "touch" all build artifacts and such but I'm
sure you get the idea).

I understand *why* it's happening (it's simply reusing the existing
Git functionality) but in the scenarios above nothing has really
changed, I should be able to pick up from where I left off, shouldn't
I?

(Obviously, I moved the discussion off track when I started talking
about Subversion, commits, and commit times. That's really just an
implementation detail and I wish I had never brought it up.)

P.S. I'm quite happy with git-new-workdir so I do believe I have a
good workaround.
