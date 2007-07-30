From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 19:43:10 -0700 (PDT)
Message-ID: <498048.62681.qm@web51002.mail.re2.yahoo.com>
References: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 04:43:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFLE3-0003x0-NX
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 04:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936593AbXG3CnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 22:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936565AbXG3CnM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 22:43:12 -0400
Received: from web51002.mail.re2.yahoo.com ([206.190.38.133]:22894 "HELO
	web51002.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932142AbXG3CnL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 22:43:11 -0400
Received: (qmail 64905 invoked by uid 60001); 30 Jul 2007 02:43:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=G4E5IpRpxNi61mFGPfPmevKjxUCBtKiBXMGKyOEBJDt5LF5mu9hl2RKIGuthBkxWTiWs3Ua3o6TekLDZBeYFGMVMQzUq571yg3T8Ttrk5N57golhWSGHzVYYyEELiFW1t+KL+5h4xRivuPTMADDUo/ifpzSzLTBA381mmMlZUOk=;
X-YMail-OSG: cjPR9ngVM1lz6ZCGMAC8FYkQPR1NdVZpxpCok4Wth_813b0MSEqaXA_wN8o30nNGV9nV4Qzn3MMsrh5UYLSdtpQX6vtnb5LJB_GeYh4PhpAe93vMhgX26euCY_No9Q--
Received: from [208.58.8.179] by web51002.mail.re2.yahoo.com via HTTP; Sun, 29 Jul 2007 19:43:10 PDT
In-Reply-To: <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54171>


--- Linus Torvalds <torvalds@linux-foundation.org> wrote:

> The fact is, distributed history isn't one-dimensional. You *cannot* 
> linearize it as some one-dimensional time. Impossible. Any system that 
> tries is broken. 

I don't want distributed history, I want what local time changes were merged locally. That is why
I described a separate view for this feature, this feature request is not meant to replace how
time is currently not being used. :)

-Matt


       
____________________________________________________________________________________
Pinpoint customers who are looking for what you sell. 
http://searchmarketing.yahoo.com/
