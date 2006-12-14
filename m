X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:23:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612141221300.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612140116430.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612141021.12637.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 14 Dec 2006 17:24:11 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <200612141021.12637.andyparkins@gmail.com>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34376>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuuJV-0008C1-78 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 18:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932876AbWLNRXr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 12:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWLNRXq
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 12:23:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40889 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932876AbWLNRXq (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 12:23:46 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JA9008W9XNLUMA0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Thu,
 14 Dec 2006 12:23:45 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Andy Parkins wrote:

> > Besides, The fact that revert _adds_ to history is a nice way to
> > document that you reverted that change. And you can even explain in the
> > commit message, why you did it.
> 
> I'm not disputing that the /operation/ is useful, I'm arguing that it is 
> incorrectly named.

Well, people are used to say they've "reverted" a change.  Although the 
command might appear slightly misnamed wrt its operation, it still does 
what most people are expecting from such a name.


