From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: planning a new topgit release
Date: Sun, 3 Oct 2010 23:21:42 +0200
Message-ID: <AANLkTim3gnU+_krD2QM0BAMf9DZi2_4hva6dq4WXcatH@mail.gmail.com>
References: <20101003191532.GA28679@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Simons <simons@cryp.to>, pasky@suse.cz,
	Per Cederqvist <ceder@lysator.liu.se>,
	Olaf Dabrunz <odabrunz@gmx.net>,
	Thomas Moschny <thomas.moschny@gmx.de>,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sun Oct 03 23:21:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2W0C-0002kM-Q3
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 23:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755179Ab0JCVVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 17:21:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58054 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab0JCVVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 17:21:42 -0400
Received: by iwn5 with SMTP id 5so6094306iwn.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 14:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ND6ep32di+vQ7vbNC3hdNgNqijC6AGOfw65PAbjV4zA=;
        b=KUqFPRDPKhw2kjn5Ly1plyQelNwDLVptR6XqypDE8fRMs27jfs9BA91kv0o4PM/8D7
         7lx95+PEE9PGvyIZ4/KKzMQHFdG2czJmJ2bXH0M+YG48paaOZ9j7DSp5+43kyL+EJjag
         AUfiwIP45iM9c2ieYtPhggfVCWYvh2WNpAMKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EBiDWpbkYzAGFoEOk0KnMeSdCHJWaIbKgeqBKq+06jgsw2H981Fw7DdbNM9MNtr0nW
         1+h4JaHDYUP0v7XEwgCLf87OgFPCEEYFY4Tl2ZfhXK/eZ5cStBzSJwBJfzfi+TnE4WKt
         +YLo9Z5ySkI28n5nTUUt46dHzlTJ3wQTvovbs=
Received: by 10.231.32.130 with SMTP id c2mr8104836ibd.28.1286140902096; Sun,
 03 Oct 2010 14:21:42 -0700 (PDT)
Received: by 10.231.171.149 with HTTP; Sun, 3 Oct 2010 14:21:41 -0700 (PDT)
In-Reply-To: <20101003191532.GA28679@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157927>

Hey,

2010/10/3 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> In the last few days I got two mails about the status of topgit and w=
as
> asked about a new release.
>
> I'm willing to create a release as 0.8 was done quite some time ago a=
nd
> there were several patches merged since then---mostly bugfixes.
>
> I'm sure I missed questions and patches in the recent past, so I ask =
you
> to resend anything you still have pending to me to get it included in
> 0.9.

Thanks for the heads-up. I will send my low and long hanging fruits in
reply to this message. I haven't followed master recently. The missing
important patch is the tg-graph one (which is probably my most used
command these days). Which Per may find interesting, Maybe I find the
time this week to update and send this out.

Bert

>
> Thanks
> Uwe
