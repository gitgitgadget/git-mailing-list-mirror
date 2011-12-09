From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] t3040 (subprojects-basic): modernize style
Date: Fri, 9 Dec 2011 13:26:49 +0530
Message-ID: <CALkWK0nbp465915ysrBXi46mur1dutBDtPNjwW=RdyPV03crzg@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-3-git-send-email-artagnon@gmail.com> <20111208163448.GA2394@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 08:57:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYvKX-0000zI-5K
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 08:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab1LIH5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 02:57:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46216 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab1LIH5L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 02:57:11 -0500
Received: by wgbdr13 with SMTP id dr13so5195965wgb.1
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 23:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MOkNVsj2DNFmV70DlJb4mUEhKI31H4A7yA7XV9O5NHs=;
        b=J2ILpSvxVLRO9J/ClmElheLqEQUGDBH+L5XOKSeQjqkInk1xsk8qhtO9nktPq3WfIJ
         d8NCAFiFnl9OvnMypehbH/Ey48k2CfTz7HhjUiLuA5GU11+JQKLPgJNTVylieuIPy6tY
         J8aGpRe8tnP7K1J2sCxIRVrgFn5TesiYCzGq8=
Received: by 10.227.209.9 with SMTP id ge9mr6287277wbb.1.1323417430194; Thu,
 08 Dec 2011 23:57:10 -0800 (PST)
Received: by 10.216.51.141 with HTTP; Thu, 8 Dec 2011 23:56:49 -0800 (PST)
In-Reply-To: <20111208163448.GA2394@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186615>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Put the opening quote starting each test on the same line as the
>> test_expect_* invocation. =C2=A0While at it:
>
> I suspect the above description, while it does describe your patch,
> does not describe the _reason_ that the patch exists or that someone
> would want to apply it. =C2=A0Isn't it something more like:
> [...]

Right, fixed.

> I didn't read over the patch again. =C2=A0Has it changed since v1?

No.  I refrained from making other style changes and/ or combining test=
s.

-- Ram
