From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Teach git-mergetool about Apple's opendiff/FileMerge
Date: Fri, 23 Mar 2007 10:15:19 -0400
Message-ID: <20070323141519.GA19649@thunk.org>
References: <20070322213728.GD3854@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Fri Mar 23 15:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUkYu-0007aP-Pz
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 15:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXCWOPi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 10:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934279AbXCWOPh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 10:15:37 -0400
Received: from THUNK.ORG ([69.25.196.29]:45111 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751682AbXCWOPg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 10:15:36 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HUkeB-0001hQ-Ng; Fri, 23 Mar 2007 10:21:39 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HUkY4-00036X-0C; Fri, 23 Mar 2007 10:15:20 -0400
Content-Disposition: inline
In-Reply-To: <20070322213728.GD3854@regex.yaph.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42934>

Thanks for extending mergetool to use opendiff!

I won't have access to my MacOS X machine until I get back home, so I
won't be able to try out your patch until early next week.  Is
opendiff in the standard MacOS release, or do I have to do something
special to get it?

Thanks,

					- Ted
