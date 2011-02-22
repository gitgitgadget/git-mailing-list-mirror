From: xiaozhu <xiaozhu@gmail.com>
Subject: Re: how a patch can be accepted?
Date: Tue, 22 Feb 2011 23:28:13 +0900
Message-ID: <4D63C7FD.4040304@gmail.com>
References: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com> <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com> <4D63C095.8020206@gmail.com> <AANLkTinU14O--V5BFBibrVa_quEUeVF-vS0waLhdzn2s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 22 15:28:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrtDz-0005Bv-Qp
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 15:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab1BVO2T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 09:28:19 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54961 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781Ab1BVO2S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 09:28:18 -0500
Received: by iwn34 with SMTP id 34so599044iwn.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NQvynMHPlGWaH/fi95LKO8AsY2NW6nbxr+APx33hyg0=;
        b=Bhedk8J1r2Dacc1VEu22uO3TdP+hdJOhogzzc0FyEU8dySOWkjgtO59WFQDfoR9Uls
         DjJsIRlWiakzICZbYfD0TN5Qxw2Q6ydpnv99YHH4SAjyX6ae/yd1L8D/m18RP6swppdV
         z4zkO2ILxzTdOks3iv+x1UN4L/vHAwXNz/Ox4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=bnBm9diiVhzT3Gs+Mkpw2QopQwyJydU26rcRmSCcPs5dvUN+DNJ2kFapJIJ/53DqZv
         Xn9JigC+R0kISsNrPytqXDys18WOX4sIuIHuS3LVl/7tpiYUAHtMFnS/irBwafpVF1ec
         QRn5+KNgDbrXIlETDSK675LcwKfnbz6WcUZAo=
Received: by 10.42.221.68 with SMTP id ib4mr3470247icb.386.1298384897959;
        Tue, 22 Feb 2011 06:28:17 -0800 (PST)
Received: from [192.168.11.57] (softbank126036243176.bbtec.net [126.36.243.176])
        by mx.google.com with ESMTPS id z4sm6295791ibg.7.2011.02.22.06.28.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 06:28:16 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTinU14O--V5BFBibrVa_quEUeVF-vS0waLhdzn2s@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167547>

On 2011/02/22 23:08, Erik Faye-Lund wrote:
> On Tue, Feb 22, 2011 at 2:56 PM, xiaozhu<xiaozhu@gmail.com>  wrote:
>> On 2011/02/22 1:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>> On Mon, Feb 21, 2011 at 15:48, xzer<xiaozhu@gmail.com>    wrote:
>>>>
>>>> I submitted a patch recently by sending a mail to this mail list, =
but
>>>> I don't know how it can be accepted or rejected? Is that enough ju=
st
>>>> send a mail to here? Because the patch is a very important fix to =
my
>>>> usage and I don't want to apply it every time by myself.
>>>
>>> Did you read Documentation/SubmittingPatches?
>>
>> Where is the Documentation/SubmittingPatches? I didn't see anything
>> about submitting a patch on the site of git, and I also tried to fin=
d
>> something about it on git wiki, but I got nothing.
>
> It's in the Git source tree.

Thank you very much, I got it.
