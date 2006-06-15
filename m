From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: Autoconf/Automake
Date: Thu, 15 Jun 2006 23:32:21 +0300
Message-ID: <20060615233221.7ad33aea.tihirvon@gmail.com>
References: <1150324030.23268.12.camel@dv>
	<20060615072450.GF7766@nowhere.earth>
	<20060615133146.GA5794@steel.home>
	<20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 15 22:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqyVp-00032V-Ef
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 22:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031290AbWFOUcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 16:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031291AbWFOUcI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 16:32:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:25695 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1031290AbWFOUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jun 2006 16:32:07 -0400
Received: by nf-out-0910.google.com with SMTP id y25so307156nfb
        for <git@vger.kernel.org>; Thu, 15 Jun 2006 13:32:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mUBo31Onn6SYKZ9jGCzABID0EKdICe3mBkba6JTMnmXlzc/+upkgi+1fP6qPm3wkVLrmmGnJdnZeAakoRHggMObs+FcdPmNkz0p8MBkRyu1SzZn4b5KpkZRrpE3F1ombKBPYfTOGzQOlsvZgozabZoie5qAPKLpoMcrn67SC3WI=
Received: by 10.49.72.13 with SMTP id z13mr922076nfk;
        Thu, 15 Jun 2006 13:32:05 -0700 (PDT)
Received: from garlic.home.net ( [82.128.201.71])
        by mx.gmail.com with ESMTP id p45sm1115901nfa.2006.06.15.13.32.03;
        Thu, 15 Jun 2006 13:32:04 -0700 (PDT)
To: news@derived-software.ltd.uk
In-Reply-To: <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21905>

Phil Richards <news@derived-software.ltd.uk> wrote:

> Well, since Python is already a dependency, why not use a build system
> that has Python as its scripting/extension language?  It's also quite
> small, and it's called SCons.  I found it rather easy to learn
> when I was having a quick look around at alternative build systems.

Only git-merge-recursive depends on Python. I hope it will be rewritten
in C some day.

-- 
http://onion.dynserv.net/~timo/
