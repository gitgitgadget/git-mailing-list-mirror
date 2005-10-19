From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Fwd: cg-merge should use git-merge
Date: Thu, 20 Oct 2005 00:21:47 +1300
Message-ID: <46a038f90510190421l50b2c12k495db23b62015782@mail.gmail.com>
References: <46a038f90510161644l35119401rdc05c081506ae715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 19 13:24:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESC15-0008Iv-Bi
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 13:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVJSLVv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJSLVv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 07:21:51 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:16157 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbVJSLVv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 07:21:51 -0400
Received: by qproxy.gmail.com with SMTP id v40so59086qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 04:21:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RCDPgFZyywlTsl/EM9Y1fP5XsDNGau+xYw44PkVSUFMDpT6yB9pXqdfJWpWn+Ngu4sjJhE88mUloiVrNouxmdIBQaxgVX09IWo+Bc4fAlhzWFFQMXL6MIRF7S0Owb6FsIvdWI6TiJvay38JYCMzNJdROwu1jTFoZBuSKMwOXk20=
Received: by 10.65.192.11 with SMTP id u11mr413517qbp;
        Wed, 19 Oct 2005 04:21:47 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 04:21:47 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <46a038f90510161644l35119401rdc05c081506ae715@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10285>

Resending a post that never made it to the list due to a bug at my
end, and I think warrants some more discussion. Unfortunately, I'm
bug-fixing at the moment, so implementing this has taken a backseat.

---------- Forwarded message ----------
From: Martin Langhoff <martin.langhoff@gmail.com>
Date: Oct 17, 2005 12:44 PM
Subject: cg-merge should use git-merge
To: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>


Petr,

After using git-merge a few times by hand to test-drive the new merge
drivers, I'm sold on the idea, and I 'd like to have cg-merge use
git-merge directly. I'll try and find the time one of these evenings
to outline something, but I guess it's pretty core to Cogito, so I'm
after some direction from you ;)



martin
