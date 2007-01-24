From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Wed, 24 Jan 2007 22:08:42 +0100
Message-ID: <46d6db660701241308l36d6c80ai4437996b67a76c32@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
	 <fcaeb9bf0701232312t5889efa6w58bb3abfa2f53ebd@mail.gmail.com>
	 <Pine.LNX.4.64.0701240834190.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 22:10:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9pMZ-0000BI-4n
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 22:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbXAXVIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 16:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbXAXVIp
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 16:08:45 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:39731 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbXAXVIo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 16:08:44 -0500
Received: by an-out-0708.google.com with SMTP id b33so175521ana
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 13:08:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z4kkPTB7ecUXBRmti61SkeoUdYlWTxzJWyxLd2ymnJHBrdIxJ4RtKDh9R2nJJ1IlLwV5TjRMnl5h6YLQQpw44AuAewsSGifa8L78jXJ+FEG5VMuUPvch9L1dRZMsVF7nN8aFu69CG7PKZUUbohGQoZJoPpDaWc8N5kGPQlCVppw=
Received: by 10.114.126.1 with SMTP id y1mr49011wac.1169672922844;
        Wed, 24 Jan 2007 13:08:42 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Wed, 24 Jan 2007 13:08:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0701240834190.3606@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37681>

On 1/24/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Ahh, that's perfect. There are even RPM's for mingw around, since that
> seems to be what some Wine people use for testing.
>
> And I don't really want to _work_ inside some wine setup anyway, so being
> able to try to cross-compile from a sane development environment was
> exactly what I was hoping for.
>
> No promises, but if I get any free time, I'll look at it a bit.
>

I'm using both Windows and Linux/Solaris. Since I've used
git on both unixes, I've been waiting for a native/mingw port.

You may have realized by now that the git community has
created quite an addictive product: with a Windows port,
the door is open to many things, gui based or not...

I'll start some c++ projects soon, and for them I'm stuck
on a Windows machine (corporatism...). I'm sure I'm not
alone in this kind of situation...

With this recent port, I'm convinced I'll progress faster:
"foo" branches is to my mind _the_ feature of git.

Thanks Linus and all for taking into account this suggestion!
:)

-- 
Christian
