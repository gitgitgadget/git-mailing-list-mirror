From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: how a patch can be accepted?
Date: Tue, 22 Feb 2011 15:08:49 +0100
Message-ID: <AANLkTinU14O--V5BFBibrVa_quEUeVF-vS0waLhdzn2s@mail.gmail.com>
References: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com>
 <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com> <4D63C095.8020206@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: xiaozhu <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 15:10:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrswN-0003wK-S5
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 15:10:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123Ab1BVOKF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 09:10:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43677 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1BVOKE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 09:10:04 -0500
Received: by fxm17 with SMTP id 17so2783623fxm.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=kFD6URk6khAPRpe54Hg+bo1VXU5uXFg+72Sd2jrz5jQ=;
        b=Qc1+kgh/DV3+v6q3kOwp0eJDOXPyWIVhKoWHy9RH0reIDEA4CT+6iRARpQE243KtwA
         U45uMRG+cA6XJBG5VD8lOBRPFJldhT+bboKCbRHFENqbeiVro23hIOyopa+H4nRW2NhM
         vwOxx79ZJoagL/cHwFZAgPAdIHGflulv3sAxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=fzV7FKhkEDlRExP4HVFsm9m9sVyfIXD2iNTZ4W3H2DM7Kqo3JdrgbhqhszyTcPpxX+
         cPCuBq4ccnijBx+hGvveQh/aRGa4ThbgBY8jSavouMYrNrSpvOHRtNCRBaBfto5gXR8H
         v5k/2UblJMYGSH1+t5slRtR6L2Vs4+tPUm1IY=
Received: by 10.223.62.12 with SMTP id v12mr1607356fah.9.1298383802376; Tue,
 22 Feb 2011 06:10:02 -0800 (PST)
Received: by 10.223.95.206 with HTTP; Tue, 22 Feb 2011 06:08:49 -0800 (PST)
In-Reply-To: <4D63C095.8020206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167546>

On Tue, Feb 22, 2011 at 2:56 PM, xiaozhu <xiaozhu@gmail.com> wrote:
> On 2011/02/22 1:23, =C6var Arnfj=F6r=F0 Bjarmason wrote:
>>
>> On Mon, Feb 21, 2011 at 15:48, xzer<xiaozhu@gmail.com> =A0wrote:
>>>
>>> I submitted a patch recently by sending a mail to this mail list, b=
ut
>>> I don't know how it can be accepted or rejected? Is that enough jus=
t
>>> send a mail to here? Because the patch is a very important fix to m=
y
>>> usage and I don't want to apply it every time by myself.
>>
>> Did you read Documentation/SubmittingPatches?
>
> Where is the Documentation/SubmittingPatches? I didn't see anything
> about submitting a patch on the site of git, and I also tried to find
> something about it on git wiki, but I got nothing.

It's in the Git source tree.
