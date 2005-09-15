From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: git version
Date: Thu, 15 Sep 2005 12:02:38 -0400
Message-ID: <43299B1E.1050407@gmail.com>
References: <u5tzmqeqw6z.fsf@lysator.liu.se> <432985A7.5070900@gmail.com> <u5tslw6qrtu.fsf@lysator.liu.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 15 18:07:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFwCF-0003wE-QB
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 18:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030492AbVIOQCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVIOQCo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 12:02:44 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:44094 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030492AbVIOQCn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 12:02:43 -0400
Received: by xproxy.gmail.com with SMTP id h28so307690wxd
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 09:02:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=O5h2dfb1x7oDAKP1a/GYwoChMEVt3k7hN8kgu82yJgTU202Lol2wnbk+mMeWwX6oxYmDquGIz6ot+IYUXAR6MmX1nvY7KbZW98tCNMVoNs5osAyfHNp35k27YscCFJgaAI0lIlAoZ1hCRU5YPKUFGTq55IPEuFD7919wE6wTji4=
Received: by 10.70.87.14 with SMTP id k14mr867331wxb;
        Thu, 15 Sep 2005 09:02:41 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id h12sm565567wxd.2005.09.15.09.02.39;
        Thu, 15 Sep 2005 09:02:40 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git Mailing List <git@vger.kernel.org>
In-Reply-To: <u5tslw6qrtu.fsf@lysator.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8612>

David K=E5gedal wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
>=20
>>David K=E5gedal wrote:
>>>Why is "git --version" called so, and not "git version"?  It works
>>>just like any other command, except that it is implemented internall=
y
>>>in the git script.
>>>The "git" command takes a subcommand that does some action or simply
>>>prints some informational output.  The "version" subcommand fits
>>>nicely into that, and I don't see any need to prepend "--" to it.
>>>
>>Consistency with other (non Git) commands was why I suggested the=20
>>"--version" form when the discussion happened.
>=20
> You mean, like, "cvs version"?
>=20
> Actually, cvs has both, with different semantics.

More along the lines of *ALL* the GNU utilities.
