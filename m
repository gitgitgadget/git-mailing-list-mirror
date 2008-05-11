From: Tim Stoakes <tim@stoakes.net>
Subject: Re: [PATCH] Add svn-compatible "blame" output format to git-svn
Date: Sun, 11 May 2008 23:16:34 +0930
Message-ID: <20080511134633.GA17723@mail.stoakes.net>
References: <20080510212504.GA26701@midwinter.com> <7vabix8t3g.fsf@gitster.siamese.dyndns.org> <20080511063601.GA23224@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun May 11 16:11:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvCGh-0008I7-UT
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 16:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYEKOK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 10:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753080AbYEKOK1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 10:10:27 -0400
Received: from hosted01.westnet.com.au ([203.10.1.211]:55315 "EHLO
	hosted01.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYEKOK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 10:10:26 -0400
X-Greylist: delayed 1418 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 May 2008 10:10:26 EDT
Received: from hosted01.westnet.com.au (hosted01.westnet.com.au [127.0.0.1])
	by hosted01.westnet.com.au (Postfix) with SMTP id 5D4A83DA4FD;
	Sun, 11 May 2008 21:46:46 +0800 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted01.westnet.com.au (Postfix) with ESMTP id 59A203DA4E0;
	Sun, 11 May 2008 21:46:40 +0800 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id DE68728C031;
	Sun, 11 May 2008 23:16:37 +0930 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id 0E4987F01F; Sun, 11 May 2008 23:16:34 +0930 (CST)
Content-Disposition: inline
In-Reply-To: <20080511063601.GA23224@mithlond.arda.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81776>

Teemu Likonen(tlikonen@iki.fi)@110508-09:36:
> Junio C Hamano wrote (2008-05-10 19:36 -0700):
> 
> > Steven Grimm <koreth@midwinter.com> writes:
> > 
> > > 	I'd actually argue that the svn-compatible format should be the
> > > 	default one, with git-compatible available as an option.
> > 
> > I'd violently agree with it.
> 
> Me too!

Likewise, thanks for completing this code.

Tim

-- 
Tim Stoakes
