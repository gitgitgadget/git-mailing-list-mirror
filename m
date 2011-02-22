From: xiaozhu <xiaozhu@gmail.com>
Subject: Re: how a patch can be accepted?
Date: Tue, 22 Feb 2011 22:56:37 +0900
Message-ID: <4D63C095.8020206@gmail.com>
References: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com> <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 14:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrsjR-0005Sz-7Y
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 14:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab1BVN4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 08:56:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33984 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab1BVN4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 08:56:41 -0500
Received: by iyb26 with SMTP id 26so1809816iyb.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 05:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=kWbZfj1sjdNISSqmykHFGAtypAUUFLcDjZO2+DDZSYw=;
        b=ZJoSI0z1hbLYarGXZlUzKUeaUfnMD5gaJChsfS9N/7zG4Xdbw8LIomCgBDIxIc5bUb
         Z9jcFfVT5U75ARrIwU/mbQkg9BTAqGnaYhV0XPEb37DPL55YvA4GkF6xyf/SQWn24opr
         jNDWlVxp3AJ5ZPHVzzGX86YVdFnPknQt6B7MU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=yAdEVeDfgdFeZizg3i/6clX/vWssHXMMXISKSkO3r4bTdGQPPAd998adC6QYFXg9Dd
         eA4+b2qKJ60Pk+u50WUS+MJT2UNmmY5h6Q3UdVEEY7YBl+8BS9vM06opLjXsvFYGDSwY
         JJsHSrOl8PLrK0yR/8CfJTZc5K7t4ZP9ZRGJg=
Received: by 10.42.171.8 with SMTP id h8mr3490148icz.475.1298383001110;
        Tue, 22 Feb 2011 05:56:41 -0800 (PST)
Received: from [192.168.11.57] (softbank126036243176.bbtec.net [126.36.243.176])
        by mx.google.com with ESMTPS id u9sm6279739ibe.14.2011.02.22.05.56.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 05:56:40 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167544>

On 2011/02/22 1:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Feb 21, 2011 at 15:48, xzer<xiaozhu@gmail.com>  wrote:
>> I submitted a patch recently by sending a mail to this mail list, bu=
t
>> I don't know how it can be accepted or rejected? Is that enough just
>> send a mail to here? Because the patch is a very important fix to my
>> usage and I don't want to apply it every time by myself.
>
> Did you read Documentation/SubmittingPatches?

Where is the Documentation/SubmittingPatches? I didn't see anything
about submitting a patch on the site of git, and I also tried to find
something about it on git wiki, but I got nothing.
