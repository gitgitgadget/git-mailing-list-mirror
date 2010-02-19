From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Fri, 19 Feb 2010 09:20:31 +0530
Message-ID: <e72faaa81002181950q18a80f31p96d9f8f05c968e01@mail.gmail.com>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
	 <46d6db661002181534r10a887b5gcc23435cb8952f13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 04:50:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiJsz-0004o1-V7
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 04:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336Ab0BSDud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 22:50:33 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:57351 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab0BSDuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 22:50:32 -0500
Received: by ywh35 with SMTP id 35so1720755ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 19:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=t8fInO06jYFoU8DwvOuupHT3goH7mtyOA6HSkZv32AQ=;
        b=VAurICp1JTVDQ8+czYQAe/FkuEazpj7nRF6fyAAVl8jcxVnEKY/sIi8fg2wvqj+5YN
         qW4X+AFkAjPxyBpbRH2/v8/gkMDpuP7fXYp6jMeDPSSblUxtk3SanoT0JAjSbojH4JQZ
         qstK6FfwYy0i4BWJHf4VuLWxakjR+fZFigqqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gIL2Y08lY+fm27R4ScQvcEzCyYT2PQEsByBMSap+SPIXRw/Dis05zKI/PIdvfpqK5Z
         hwfSlrXZJGrgMdxA1VKbEnu+jpOu2Cx0bux4InCwFMZv4Za7Tqb9GaqJU9rAwflSWgSC
         Jpve2IpwYDLI2talpDBrIkC0Mvi3ExKWe0HZw=
Received: by 10.90.15.14 with SMTP id 14mr3299110ago.2.1266551431715; Thu, 18 
	Feb 2010 19:50:31 -0800 (PST)
In-Reply-To: <46d6db661002181534r10a887b5gcc23435cb8952f13@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140404>

>
> maybe rather than just autocompletion, it does help new code to land
> in the right place ? I think just for this reason at least it's a good
> move.
>
> I've a wild idea on a new command to add to git and I was pondering
> between having it as a perl script or a builtin. Now I know where it
> should go if I choose a builtin, provided you get a wide consensus.
>

I agree with this. This will be very good to guys who want to start
understanding the code completely
