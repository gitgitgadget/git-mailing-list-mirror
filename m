From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Thu, 16 Sep 2010 14:02:12 +0000
Message-ID: <AANLkTim4M_KfuZoe5z_upPug5AT=P-_EfvPcxDe8-uPn@mail.gmail.com>
References: <20100912202111.B11522FC00@perkele>
	<alpine.DEB.2.00.1009151124100.11791@ds9.cixit.se>
	<A612847CFE53224C91B23E3A5B48BAC749BFA3D12C@xmail3.se.axis.com>
	<201009160046.47367.robin.rosenberg@dewire.com>
	<alpine.DEB.2.00.1009161209500.18826@ds9.cixit.se>
	<AANLkTin_5drpRva6jiwwC-OpMSxnYwJu5fJD4aU7P5jq@mail.gmail.com>
	<4C92227B.70800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	Git <git@vger.kernel.org>, Swedish <tp-sv@listor.tp-sv.se>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 16:02:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwF2e-0001Fe-Vx
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 16:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab0IPOCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 10:02:14 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38083 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab0IPOCN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 10:02:13 -0400
Received: by gxk23 with SMTP id 23so407294gxk.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fFiJ7cQkERt19MbCdsZFkXDk5uBmgpJp8LbjvcMmd4c=;
        b=rVgG3Mge+35RnH5/g+qERknGvjkohXDPva4yutdJxuA+7knrNYOKBfWKuBrbfBNqiN
         laUS7YxitKx5Sv/Gz5O33bU8YdDizkt5aLK8eQMzxQRUKAKMKzQNE1TOyw+5uITdhZCE
         loVm9XPHO1DkGx8IjIdY1MOdK4hVPwusNDP2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UETPL/yIugrI1t93irH4xzkeJWjgS/mT/Xz+WIGBq1mUcKXX97WU6Xj+TdMmwbZZ3u
         7C170IqWqtNMZA25eqCveUJ5P08/2g37E2dEWG1+y5fqwU41xUkAlilYvDMhreraE+Li
         X3NLitAjf37T94YFjfvYl666Ggn/F0/pSHpnQ=
Received: by 10.150.140.1 with SMTP id n1mr3818937ybd.4.1284645732972; Thu, 16
 Sep 2010 07:02:12 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 07:02:12 -0700 (PDT)
In-Reply-To: <4C92227B.70800@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156335>

On Thu, Sep 16, 2010 at 13:58, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 16.09.2010=
 13:41:
>> On Thu, Sep 16, 2010 at 11:23, Peter Krefting <peter@softwolves.pp.s=
e> wrote:
>>> Robin Rosenberg:
>>>> (My comments are in swedish as it feels more natural in this conte=
xt).
>>>
>>> While I do agree, I'm trying to reply in English since the Git list=
 is in
>>> English.
>>
>> Usually yeah, but when a PO file is under discussion only people tha=
t
>> speak the language can contribute usefully anyway, so I think it's O=
K
>> if that discussion is not in English.
>
> How about "[L10N SE] etc." subject lines etc.? That way people can
> easily filter out all L10N posts but keep those relevant to them
> (including their language).

Sounds good, but convincing people to submit posts with those subjects
consistently is the hard part :)

> I'm trying to advocate "Marke" for DE ;)
> In fact, subversion seems to be a good source for inspiration - at le=
ast
> for the terms...

Yeah, languages that benefit from existing SCM translations should
definitely be looking at those, even if those SCM's aren't distributed
there's a lot of common vocabulary.
