From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: SVN interpreter (Re: [PATCH] cg-diff fixed to work with BSD xargs)
Date: Thu, 22 Sep 2005 07:32:31 +1200
Message-ID: <46a038f905092112326485c50b@mail.gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 21:35:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIAKZ-0005Su-Gr
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 21:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbVIUTcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVIUTcd
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 15:32:33 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:20781 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751396AbVIUTcc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 15:32:32 -0400
Received: by qproxy.gmail.com with SMTP id v40so367027qbe
        for <git@vger.kernel.org>; Wed, 21 Sep 2005 12:32:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KziD2Oa27eyyhoLD3B8V6bzxXR+O2a9R+idOOHjf3xx5LIn9gJsLDn6VX0Fr/oYzxRNa9eIxsnVOFmZvj8xDkqWUDGlJ5a2ieFQVDbXA6MYCnWW1uzu4sbPtGOl8qrke+bRBVAtsoKqgB3so2TZ71jLI8SpLC4F1H/P5HqU1wdo=
Received: by 10.65.38.2 with SMTP id q2mr134434qbj;
        Wed, 21 Sep 2005 12:32:31 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 21 Sep 2005 12:32:31 -0700 (PDT)
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9070>

On 9/21/05, Matthias Urlichs <smurf@smurf.noris.de> wrote:
> Of course, I also need a few hours to complete the SVN interpreter, and

Have you had a look at Tailor.py? I think it'll do SVN to GIT... it
definitely does Arch to GIT. Its main limitation is that it doesn't
know a thing about branches or merges. But it'll import a linear
history reasonably well, I hear.

cheers,


martin
