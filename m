From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 18:48:11 -0700 (PDT)
Message-ID: <20060928014811.19568.qmail@web51005.mail.yahoo.com>
References: <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 03:48:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSl0a-0005pY-9c
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 03:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbWI1BsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 21:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWI1BsN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 21:48:13 -0400
Received: from web51005.mail.yahoo.com ([206.190.38.136]:18567 "HELO
	web51005.mail.yahoo.com") by vger.kernel.org with SMTP
	id S965083AbWI1BsM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 21:48:12 -0400
Received: (qmail 19570 invoked by uid 60001); 28 Sep 2006 01:48:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=n8NE92RbufU3AURaT3I+1TZZIEJr+qRkQrZM4vpeH7aNjXi2GK7Gwj9o0eObYyCswy83pdMEVPINHaHIv3ysFo6MRUJT8zGrKrvaCEX4gi0PNJj/mrvqT78KB42SZBzJ4djl+PrE2Z86npHD4QltLD9ZMu0e1OLV3RmYLTOGgL8=  ;
Received: from [207.172.80.85] by web51005.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 18:48:11 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27964>

--- Junio C Hamano <junkio@cox.net> wrote:

> This must be a trick question.  git does not trust _any_
> timestamp, so there is no local "rather than" remote.

I actually understand that and agree. All I've been saying is it (git or gitweb.cgi) should prefer
the local timestamp rather than any "remote" timestamps for no other reason than to minimize the
possibility of timestamps being grossly inaccurate.

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
