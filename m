From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 09:53:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609280949030.3952@g5.osdl.org>
References: <d620685f0609271749p30da81d6p25cb759bf793d327@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:54:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSz9F-00049K-Hn
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbWI1QyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbWI1QyD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:54:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20929 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751932AbWI1QyB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 12:54:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8SGrvnW019096
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 09:53:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8SGrueZ014585;
	Thu, 28 Sep 2006 09:53:56 -0700
To: apodtele <apodtele@gmail.com>
In-Reply-To: <d620685f0609271749p30da81d6p25cb759bf793d327@mail.gmail.com>
X-Spam-Status: No, hits=-0.461 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28019>



On Wed, 27 Sep 2006, apodtele wrote:
>
> Shall we summarize? Time is a very important concept in physics.

Actually, even in physics (or very _much_ in physics), time doesn't 
follow the nice procession that Matthew is kind of asking for.

In physics, particles can go backwards in time or forwards in time (the 
_likelihood_ that a photon moves at exactly the speed of light is higher, 
but on a quantum scale, strange things happen). 

And everybody should by now know what relativity says: time does not 
impose an "ordering" of events outside of the so-called "cone of light". 
There is only an ordering imposed by _causality_, not by time.

That, btw, is very similar to git. The only _true_ ordering in git is 
causality. Time itself tends to have certain properties that makes it 
_look_ like it is about causality, but in real life there is just a strong 
correlation.

Nature is sometimes stranger than our everyday experiences would have us 
believe. And "time" is a hell of a lot more complicated than just a global 
one-dimensional entity, steadily ticking away.

			Linus
