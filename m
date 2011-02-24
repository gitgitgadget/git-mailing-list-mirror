From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: ab/i18n (What's cooking in git.git (Feb 2011, #05; Wed, 23))
Date: Thu, 24 Feb 2011 11:40:21 +0100
Message-ID: <AANLkTi=RPAmswfcxSDMtaBwD55kkfbT5Qj-n7jmoRTy0@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<20110223234828.GA7286@elie>
	<AANLkTimn_CmWORwJfWXEiY18QCmXdNZMhCUC9YBMo_kV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 24 11:40:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYcW-0004BU-Br
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 11:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345Ab1BXKkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Feb 2011 05:40:23 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43071 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab1BXKkW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Feb 2011 05:40:22 -0500
Received: by fxm17 with SMTP id 17so391875fxm.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 02:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ivFzCKwxWfMkFk2Esx9wwL/a2V4aVM+HpBtO7ifPsBQ=;
        b=HbUIHoE4APwA5Ig8RpaviJGA4yME2saKvoWgtvFYlbx6BqyBeh28E3dDu8v/KkHl8d
         ZSPeq1j6uJhUpQr6Vn18Mn5DYQxYaSt63hWpWDE/dVmDmAeG9sqqkr40Ca6I2DNfSIM3
         nvG/lbDwCbheD3InMaSuI84TJGEntvwpjTn2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UxXQIRnYK+5GtChdUrWXQU8dCd8Lezc+552/cs5YslP0fKcsQfZwjA+L6fnPlYsJEh
         oth5xrxtmMbTPIxO3YdJKu9AatgGo6wwJr89llDd2XVO1Z8R69EvWWy6eMkFGnqqBG5C
         S8059wtSKUPkWqTdnooQdZBzOI7NnV+/vshos=
Received: by 10.223.72.14 with SMTP id k14mr822842faj.45.1298544021505; Thu,
 24 Feb 2011 02:40:21 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Thu, 24 Feb 2011 02:40:21 -0800 (PST)
In-Reply-To: <AANLkTimn_CmWORwJfWXEiY18QCmXdNZMhCUC9YBMo_kV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167797>

On Thu, Feb 24, 2011 at 10:56, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Thu, Feb 24, 2011 at 12:48 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>> There is also a patch out there to make this use rot13, which I am
>> somewhat fond of. =C2=A0Unfortunately, it leaks (because it is not c=
lear
>> how long translated strings are supposed to last).
>>
>
> I like the idea, but perhaps we could auto-generate a Pig Latin
> translation or something instead? Pig Latin has the benefit over
> rot-13 of the strings being of a different length than the original,
> which might trigger some bugs that same-length translations might
> not...

At the risk of sounding too succinct.

"dudes"

:)
