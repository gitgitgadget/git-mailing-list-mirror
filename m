From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: Re: Re: git gui create desktop icon currently does not work
Date: Sat, 27 Feb 2010 23:09:48 +0100
Message-ID: <cb7bb73a1002271409n1968c771w6a39c5595a89a834@mail.gmail.com>
References: <20100223224955.GB11271@book.hvoigt.net> <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com> 
	<20100223230238.GD11271@book.hvoigt.net> <cb7bb73a1002242353h739786bdlb2c57df3438f5b7f@mail.gmail.com> 
	<20100227204108.GA33000@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 23:10:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUrZ-0001AM-RF
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 23:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936328Ab0B0WKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 17:10:11 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:50315 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936317Ab0B0WKK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 17:10:10 -0500
Received: by ey-out-2122.google.com with SMTP id 25so281700eya.19
        for <git@vger.kernel.org>; Sat, 27 Feb 2010 14:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=d60QytMTySTRkLG0ArQgZ7+5ZuQzIXGsp8fQ3ayBZ70=;
        b=hNvBeN3vwJ4MplecK3TIPEi9MwGQJfPzOAOEhwzimy9ZOsbSebV9DKQ4dLC9Q6Vr7/
         0NG7hgbEKiHnZQuNcjQiOoXGPMCuzSfJxrfSYVZW1nZ+dz7f88QnPHhvhDuccsUE5QdE
         E4n3p6ZQmYvxHohyvelrD0vjY2Js9gPwKnmjw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lQAl9nMbg89Q4YSIoywbBujbH+PYhOLzkHCE+xIf3eKSK6pjiOfiZIrSN8+SsNFh2z
         NmoZxsYXlNovEBhRMdLlB1b+xOY9cAEW3FVDVaAmV5DXHp6DCn9mLQqUGh4l6eNblTrT
         T9LlW1/BR7dQMUveO2W3Rt+IrEtEhqXRpFW9Y=
Received: by 10.213.55.73 with SMTP id t9mr1678391ebg.31.1267308608121; Sat, 
	27 Feb 2010 14:10:08 -0800 (PST)
In-Reply-To: <20100227204108.GA33000@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141233>

On Sat, Feb 27, 2010 at 9:41 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Thu, Feb 25, 2010 at 08:53:57AM +0100, Giuseppe Bilotta wrote:
>> You're right, although finding a Windows installation on which to test
>> git is nontrivial for me. (I did mention this particular part was
>> untested when I submitted it.)
>
> Ok then we can not blame you. Maybe send such a patch to the msysgit
> mailinglist and me CC then we can test early.

I should have thought about posting to the msysgit mailing list
myself. I'll remember next time 8-)

-- 
Giuseppe "Oblomov" Bilotta
