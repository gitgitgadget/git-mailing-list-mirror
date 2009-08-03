From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Working on Git on MS Windows
Date: Mon, 3 Aug 2009 18:28:41 +0200
Message-ID: <200908031828.42426.jnareb@gmail.com>
References: <d411cc4a0908030753r7bbe4038lf05c416530db46ed@mail.gmail.com> <m38wi0rine.fsf_-_@localhost.localdomain> <742707500908030906h12f29050hd792911e9c74e635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thiago Farina <thiago.farina@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:29:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY0PD-0004b6-B5
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 18:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbZHCQ2w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 12:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbZHCQ2v
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 12:28:51 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:48321 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbZHCQ2v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 12:28:51 -0400
Received: by fxm17 with SMTP id 17so2737086fxm.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=HxvtfVj+vmsx9gEyxQvHhb8dTS5Fhne0oxptKphipIc=;
        b=R5itNZ1/pdioxdHX4Hh7IWM6mktG8dpxF7BxrgKEKFpNStDV1UC19vz5kj6fNqzCfF
         Bk3L5+wyftYcE2nBHDu20TBitsj1k+xpsbIDMzvBgBdrhHdBbZygjCUzOZvz44tvJHzZ
         R1w1O37SRAyxUmdtDw9lqOdmQBHY3/wheuJJk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=od9/Zz2g7bygi1Ix33qgddAmsU77k7yIHT0/h3+tUVAV6AiNgNirb9fV6s7pCc5/6O
         B5QOlF4e+ucXtqs+hsvHHXoi9lJp+ymDt9kxw05HP6UeFZFhvoFAgUUAXbcM3ddm1TaX
         CqG7Q/+uxydrtISyXR6FCL7PITts9Sksl99EI=
Received: by 10.103.8.19 with SMTP id l19mr3681372mui.22.1249316930168;
        Mon, 03 Aug 2009 09:28:50 -0700 (PDT)
Received: from ?192.168.1.13? (abvc247.neoplus.adsl.tpnet.pl [83.8.200.247])
        by mx.google.com with ESMTPS id g1sm39422155muf.46.2009.08.03.09.28.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 09:28:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <742707500908030906h12f29050hd792911e9c74e635@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124703>

On Mon, 3 Aug 2009, Thiago Farina wrote:
> On Mon, Aug 3, 2009 at 1:02 PM, Jakub Narebski<jnareb@gmail.com> wrot=
e:
>> Thiago Farina <thiago.farina@gmail.com> writes:
>>>
>>> I'm new to git, I already downloaded the msysgit. I'm working with =
git
>>> a couples weeks now. But I want to start debugging the git source c=
ode
>>> in Windows. How can I do that? Can I do that using Visual Studio, o=
r
>>> there are other methods to debug git?
>>
>> Git uses GNU make as a build tool, so I am not sure if you can devel=
op
>> Git with MS Visual Studio. =A0You should have GNU make installed if =
you
>> have chosen appropriate version of msysGit (the one with developer
>> tools).
>
> I can build the git with make which was installed by msysGit. But I
> want to debug, not only build.

I don't know if you can debug msysGit with MS Visual Studio. I think
you should be able to, as msysGit is native Windows application. But
I do not program on MS Windows myself.

Perhaps this question should be better asked on msysGit Google Group?
http://groups.google.com/group/msysgit

--=20
Jakub Narebski

Git User's Survey 2009:
http://tinyurl.com/GitSurvey2009
