From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Git Documentation
Date: Tue, 22 Jul 2008 07:46:09 -0700
Message-ID: <d411cc4a0807220746l3dfbca0fk11364741a36da14c@mail.gmail.com>
References: <d411cc4a0807212035v68c2ed95m93b77c1e61cfec9e@mail.gmail.com>
	 <200807220917.57363.johan@herland.net>
	 <alpine.DEB.1.10.0807220035110.1125@asgard.lang.hm>
	 <200807221121.22520.johan@herland.net>
	 <alpine.DEB.1.00.0807221335560.3391@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 16:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLJ8y-0002JQ-RK
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 16:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbYGVOqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 10:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbYGVOqM
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 10:46:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:43186 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYGVOqL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 10:46:11 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1117508waf.23
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=93EKudiVW5NMt1n2ZPDKiAS1EfaQzF3wi7CWA5yuyVI=;
        b=dG83v0kkqUkXDJc351PmVZ77jfNWAVtt30VXLEollFVYos9Y9RmChbO5tobi3MbM70
         X2YeFbt1HXl1ybQNTmSGY2gPMKz7z+tahF6nUVY5YxVv6FOkZAn5sao6555861f5ygGu
         YEdzuIq9LALO/AX8OYWBZXdjVep4LL5IqqbR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=v0IUH0ubQgJcVVIIfMsOdzpVJt7GMP+DtKSvlPiMB16sIffy+BglYYqy43SH10BAhB
         hwdEIZ1m1HpSX2BtdjJ3DCAqRRbRjeVmxLZVKFDVtPCeopMScOEM5haOF/NV8waTDNDz
         u1xy0iiKCiB7XH6SHcsWwVOK1QBwiouLM0Hh0=
Received: by 10.115.108.1 with SMTP id k1mr3862947wam.109.1216737969750;
        Tue, 22 Jul 2008 07:46:09 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Tue, 22 Jul 2008 07:46:09 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807221335560.3391@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89490>

Thanks all for your input - I like the idea of the two-track thing and
I'll probably use a lot of what you've laid out to help structure the
site.  I have personally tried to do a quick under the covers overview
beforehand because I have found that it helps, but I know many of you
work with new converts a lot too, so thanks again for your feedback.

As this gets going, I'll post here with updates from time to time to
make sure not too many of you feel it's going too far off track or I'm
not making incredible mistakes anywhere.

Thanks,
Scott

On Tue, Jul 22, 2008 at 4:40 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Tue, 22 Jul 2008, Johan Herland wrote:
>
>> Many Git users will not be VCS geeks like us; they will be "regular"
>> people that use Git because it's useful for them (or because they're
>> forced to use Git at $dayjob).
>
> Exactly.  But it seems a concept hard to understand to some people.  It
> also seems that VCS geeks like scripting, and assume everybody else does,
> too.  Not so.
>
> Most people hate to know the internals.  They buy the car, and never want
> to look inside the motor compartment.  They buy wine, and never want to
> know how it is made.  They buy an iPod and never want to know who
> assembles it, and how, and in what environment.
>
> You cannot teach those people to be more interested/interesting by showing
> them how things work internally.  But you can give Git a bad reputation in
> the process.
>
> This, amongst other reasons, was why a company I worked at had a policy to
> never _ever_ have presentations or tutorials by technical staff.  Never.
>
> Ciao,
> Dscho
>
>
