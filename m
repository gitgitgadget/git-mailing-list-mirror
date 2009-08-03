From: Thiago Farina <thiago.farina@gmail.com>
Subject: Re: Working on Git on MS Windows (was: Re: Git Logo)
Date: Mon, 3 Aug 2009 13:06:49 -0300
Message-ID: <742707500908030906h12f29050hd792911e9c74e635@mail.gmail.com>
References: <d411cc4a0908030753r7bbe4038lf05c416530db46ed@mail.gmail.com>
	 <742707500908030807k138c3fcco58ccc8af26c37d7d@mail.gmail.com>
	 <m38wi0rine.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:07:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY03x-0003Px-LP
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 18:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371AbZHCQGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 12:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZHCQGw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 12:06:52 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40090 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348AbZHCQGv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 12:06:51 -0400
Received: by ewy10 with SMTP id 10so3140001ewy.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 09:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8707ADVJiFMs+83Ufi2M5bl2xBgySbPbu5fg9PGNVU0=;
        b=RBCqyPP7pGgBUQc6UszM9LQXvqtiiO2KiS0Bw6bssrQR7aTOlyHG/3HJ69IA8cqehd
         8g6TKBEoydEL4yKjdUTJqjoeJCJj+Q/0n4RQH7pq2Hwv7PuAgDadgRcx3xy8toiyNMM5
         FUWK6Ll16xMqpoychX1Dbq6aHxdL9AgI6JV6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sYCGqVWj+BSNJuan4x33WLX7/QlQZB4ik+w8NhCVhG8fpzJpNEC+JF5kEhvAZyUHNQ
         jMhb79eJqx2liLbmkpeWXKcaXviFyh41ze4AAMDYViPPY38fJ4VY7OQILAjWZinAO1il
         tSTsVC1i9BQ/yKkH8q7IrurOMFpamb5wZEwUk=
Received: by 10.216.20.67 with SMTP id o45mr1294784weo.106.1249315610141; Mon, 
	03 Aug 2009 09:06:50 -0700 (PDT)
In-Reply-To: <m38wi0rine.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124701>

On Mon, Aug 3, 2009 at 1:02 PM, Jakub Narebski<jnareb@gmail.com> wrote:
> Thiago Farina <thiago.farina@gmail.com> writes:
>
>> Hi guys,
>>
>> I'm new to git, I already downloaded the msysgit. I'm working with g=
it
>> a couples weeks now. But I want to start debugging the git source co=
de
>> in Windows. How can I do that? Can I do that using Visual Studio, or
>> there are other methods to debug git?
>>
>> Thanks all, great work!
>
> First, please do not post unrelated message as a followup; this
> message should be start of new thread, and have appropriate subject
> (like the one above).
>
> Second, do not toppost. =A0Third, only quote what is necessary.
>
>
> Git uses GNU make as a build tool, so I am not sure if you can develo=
p
> Git with MS Visual Studio. =A0You should have GNU make installed if y=
ou
> have chosen appropriate version of msysGit (the one with developer
> tools).
>
Hi Jakub,

Sorry for my mistakes, was the first time I posted to the
mailling-list, and I didn't know about this rules.
I can build the git with make which was installed by msysGit. But I
want to debug, not only build.
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
