From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Mon, 10 Dec 2007 08:38:33 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712100837300.12046@woody.linux-foundation.org>
References: <200712101357.49325.jnareb@gmail.com> <87ve76mwos.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Dec 10 17:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1lf8-0006Tp-Hp
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 17:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbXLJQiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752971AbXLJQiq
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 11:38:46 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39454 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753194AbXLJQip (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 11:38:45 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBAGcYf5002390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Dec 2007 08:38:35 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBAGcX6q009980;
	Mon, 10 Dec 2007 08:38:33 -0800
In-Reply-To: <87ve76mwos.fsf@mid.deneb.enyo.de>
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67733>



On Mon, 10 Dec 2007, Florian Weimer wrote:

> * Jakub Narebski:
> 
> > +                <s id="git">
> > +                    Yes (or no depending on interpretation). Git
> 
> This should be "No." (same for copies below).

No.

Git handles renames and copies better than most SCM's that _claim_ to 
handle them. Saying we don't do them is just stupid. We do them *right*. 
The fact that inferior systems do it differently is _their_ problem, and 
not a cause for saying that git wouldn't do them.

		Linus
