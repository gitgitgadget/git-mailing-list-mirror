From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk highlight feature
Date: Wed, 3 May 2006 12:55:29 +1000
Message-ID: <17496.7073.507895.484698@cargo.ozlabs.ibm.com>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
	<Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 04:56:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb7Wr-0007Q6-5j
	for gcvg-git@gmane.org; Wed, 03 May 2006 04:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWECCzi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 22:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbWECCzi
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 22:55:38 -0400
Received: from ozlabs.org ([203.10.76.45]:56274 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965076AbWECCzi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 22:55:38 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 6E96967A40; Wed,  3 May 2006 12:55:37 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19451>

Linus Torvalds writes:

> The obvious way to do it would be to just have two buttons per view: one 
> exclusive one (for the main view - only one selected at a time), and the 
> other one for the "highlight" one where you could allow multiple views to 
> be selected for highlighting.

That's hard to do in a menu, but I could do it in a separate pane.
Or, I could draw a series of tabs between the menu bar and the
graph/headline/author/date panes.  Each tab would have the view name,
a radiobutton to select it for highlighting, and a close button.

Paul.
