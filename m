From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Thu, 28 Sep 2006 09:55:08 -0700 (PDT)
Message-ID: <20060928165509.77413.qmail@web51001.mail.yahoo.com>
References: <451BEA60.9050306@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 18:55:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSzAJ-0004Qc-Fq
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 18:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbWI1QzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 12:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWI1QzL
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 12:55:11 -0400
Received: from web51001.mail.yahoo.com ([206.190.38.132]:36480 "HELO
	web51001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751933AbWI1QzK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 12:55:10 -0400
Received: (qmail 77415 invoked by uid 60001); 28 Sep 2006 16:55:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZEPapKLXtNHPjFVHwvvNx79FhkWJ+YhI6g2n3vcSBkmm1huY41BZV+IjMrAGLk+vzTnnfTcPzlnGjy9r6Jy5/sLANxSMe3jqSim3X8Xw07DdJpap2O7+Nn7FxCDnksKoIcdduB5IMv52j2+Y5E01DVkfymEl5Zdmm6KnRMn51sI=  ;
Received: from [207.172.80.85] by web51001.mail.yahoo.com via HTTP; Thu, 28 Sep 2006 09:55:08 PDT
To: Rogan Dawes <discard@dawes.za.net>
In-Reply-To: <451BEA60.9050306@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28020>


--- Rogan Dawes <discard@dawes.za.net> wrote:

> I just don't think that any of the kernel developers feel the need to 
> police any one else's clocks . . . they're more interested in the 
> contents of the patch.

I am not saying git should "police any one else's clocks", I am saying git should be designed or
configured in such a way, using local time, that it obviates the current reliance on everyone
else's clock being set correctly. 

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
