From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: VCS popularity
Date: Wed, 1 Apr 2015 00:30:34 +0200
Message-ID: <CAA787rnbZGv_5rmVK1MLmCMLx9vpubW87hM4XK8U65i7FDZAiA@mail.gmail.com>
References: <CAA787rkKYQ=TJezeLy0f=aGs2GR8ypuxmr2qA2py+hGsC+juVA@mail.gmail.com>
	<xmqq7ftwq06b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:30:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd4gD-0003Cu-I6
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 00:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbbCaWah convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 18:30:37 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34516 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbCaWag convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 18:30:36 -0400
Received: by lboc7 with SMTP id c7so23251270lbo.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=TKtK9PjxyPjqnBifcphRG94mZAU8wxR53U5CJODwjuE=;
        b=TLmBbGoZOyyl1U/dMGKutGxyG1OO3CzHlvhrrr18DTXUts5ZFdEbwRRHSuj98jd3rC
         CGJE4i3sO1KSPm/Umy1DPSFiDwXMM0YaDIb6ruhtg0XGPJNifBTjY7ZDsDkgjJDrZaKr
         FTjWAYJzBD9Tm2O1EZ+a822o/JVyzDNvSIWbEgHX7sl0/TEE4nIcMk9UOiIFuczTiA7D
         YJFGJGVHkSNpG91bTSGYDjHU1YGDswpMccGB9gCetPHZk1X1AATjzxf+aDYnqU1WwOCd
         9icXGdpSQPX10kFIuNB1wx18v7WqivU1gmN8oVXBvxqEaTgKQonisN92W1I1/tm1yKCX
         N9Ow==
X-Received: by 10.152.115.134 with SMTP id jo6mr19730774lab.10.1427841034741;
 Tue, 31 Mar 2015 15:30:34 -0700 (PDT)
Received: by 10.112.156.231 with HTTP; Tue, 31 Mar 2015 15:30:34 -0700 (PDT)
In-Reply-To: <xmqq7ftwq06b.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 48QwIrWb2xd-7__E3h1f6EQ_Q50
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266571>

On 1 April 2015 at 00:20, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=98yvind A. Holm <sunny@sunbase.org> writes:
> > The graphs are pretty interesting:
> >
> > https://github.com/sunny256/openhub-repositories/blob/master/graph/=
relative.svg
> >   Graphs of relative growth between the various version control sys=
tems.
>
> This plots us at a bit over 8000.
>
> What does this number mean, exactly?  Since 2014-08-01, the number of=
 Git
> repositories Ohloh knows about has grown 8000-fold?  Or is it just 80=
-fold
> (8000%) growth?  Or 8000 more repositories were created?

Yes, relative.svg and relative-zoom.svg show the number of new reposito=
ries
found by Open Hub. To be specific, these are the numbers:

Bazaar: 75
CVS: 59
Git: 8230
Mercurial: 215
Subversion: 607

These numbers can of course be discussed, but as a source, I believe Op=
en Hub
should be one of the more objective ones.

- =C3=98yvind
