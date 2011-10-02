From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Sun, 2 Oct 2011 16:45:02 -0700
Message-ID: <CAE1pOi0ybQEANkLo-ie_41s5eeRKDZL=e2sP67Avnef5VUKMmQ@mail.gmail.com>
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
	<87botznvua.fsf@an-dro.info.enstb.org>
	<vpqehyvnrbj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	Robin Rosenberg <robin.rosenberg@gmail.com>,
	Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 03 01:45:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAVio-0005S6-2i
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 01:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803Ab1JBXpG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Oct 2011 19:45:06 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60343 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab1JBXpE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2011 19:45:04 -0400
Received: by qyk30 with SMTP id 30so1632724qyk.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=EZ6N8LU4RoN+pTwSjuVPyKC9OsgjICow/TeY48KZ0BU=;
        b=mMF6bosDwBR+sFPd6KTxuXrMeJITwOVC/IQeYv9mQVm4zKnetZpl/WtnFBonDOM4oR
         UXN0D8x05JRx2ESpy5ZHF74RNusTvCZ9O3mI2wcmrQHYnZbTr3O81/ljq6bZHYnBMRdV
         ze0/aJgDWAqIBY2ccsozJHsk0xfxTu+NNEaXQ=
Received: by 10.229.64.99 with SMTP id d35mr10512797qci.277.1317599103017;
 Sun, 02 Oct 2011 16:45:03 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Sun, 2 Oct 2011 16:45:02 -0700 (PDT)
In-Reply-To: <vpqehyvnrbj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182615>

On 2 October 2011 12:09, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wr=
ote:
> Ronan Keryell <Ronan.Keryell@hpc-project.com> writes:
>
>>>>>>> On Sun, 02 Oct 2011 18:57:55 +0200, Robin Rosenberg <robin.rose=
nberg@gmail.com> said:
>>
>> =C2=A0 =C2=A0 Robin> Hilco Wijbenga skrev 2011-08-22 22.10:
>> =C2=A0 =C2=A0 >> [...] I just wish there was at least an option to k=
eep the
>> =C2=A0 =C2=A0 >> timestamp (and possibly other such things). Even Su=
bversion can
>> =C2=A0 =C2=A0 >> do that... ;-) After all, not everybody uses C& mak=
e.
>
> AFAIK, Subversion doesn't version timestamps. What it can do is to se=
t
> the timestamp to the commit date at the time the file is checked-out.

Correct and this would fix my problem, I believe.

>> =C2=A0 =C2=A0 Robin> What tools do you use that need the benefits fr=
om retaining
>> =C2=A0 =C2=A0 Robin> timestamps? =C2=A0The only one I can think of i=
s clearmake, but
>> =C2=A0 =C2=A0 Robin> then that tool goes with another SCM. Eclipse, =
for example,
>> =C2=A0 =C2=A0 Robin> will be just as confused by timestamps that tra=
vel backwards
>> =C2=A0 =C2=A0 Robin> in time, as make is.
>>
>> I think of tools called "humans", very common indeed on Earth. :-)
>
> For human beings, it's not really harder to run
>
> =C2=A0git log -1 file

I think the idea is that computers do the work, not humans... :-)

> than to look at the on-disk timestamp. And it continues working after
> you start modifying the file, so it's much less fragile than the
> filesystem timestamp.
>
> But if you insist in reproducing SVN's "use-commit-times =3D yes" set=
ting,
> it should be doable with a post-checkout hook.

Mmm, this post-checkout hook would get the commit time from the commit
and "touch" all relevant files with that timestamp? Is that easily
done?
