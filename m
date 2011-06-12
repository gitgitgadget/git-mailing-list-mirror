From: Albretch Mueller <lbrtchx@gmail.com>
Subject: Re: diff'ing files ...
Date: Sun, 12 Jun 2011 01:02:37 +0000
Message-ID: <BANLkTinpYMdLLOj62O=3=ALWsdBiECHR1g@mail.gmail.com>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
	<20110606224356.GC13697@sigill.intra.peff.net>
	<BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
	<20110607221948.GA10104@sigill.intra.peff.net>
	<alpine.LFD.2.00.1106092145390.2142@xanadu.home>
	<m34o3xesqn.fsf@localhost.localdomain>
	<alpine.LFD.2.00.1106101612060.2142@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Jun 12 03:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVZ4f-00077F-37
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 03:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab1FLBCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 21:02:40 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:32861 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271Ab1FLBCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 21:02:39 -0400
Received: by ewy4 with SMTP id 4so1273002ewy.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=SlHupw1LlOAc0lAtGB4qYog+QYNQpsq6ZLZi5oS+a88=;
        b=FWbbLMhzky7LlC9VU5jppBWGa9UFeudE3y1UkkC7I9g9qUZcjxW2+MeawqOOelFPOI
         f9vdbeN/9DLV1e3fFvqmuuOsnRiLw5/GXFMLVerTmVWrmLdGNBlUrmgG7QQQE8Lgp2Ix
         MZ+g3OS4qkLyKHsmI45FMMJEr+LChBOkArJ7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sqh5/5kQO/ENjsWSHhnyQrB4eavvIpi2yvaX0vvJq1tJ2bYILPCRpJ/G1+cOu5kuAf
         eR7lQPEA5WGnBuEKeBHscgV5o367VCdxW5bGNxz7F3p/rk6rOA1f5GfuIwWiLdlUZnED
         +0dgf2ji7pUQW6ftWJY8i1GfjeZs6dvJe0IgU=
Received: by 10.14.48.6 with SMTP id u6mr1524016eeb.37.1307840557893; Sat, 11
 Jun 2011 18:02:37 -0700 (PDT)
Received: by 10.14.119.134 with HTTP; Sat, 11 Jun 2011 18:02:37 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1106101612060.2142@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175649>

> further modifications were made to avoid pathological corner cases ...
~
 Nicolas, did you keep test samples of those pathological corner cases
you would share?
~
 lbrtchx
