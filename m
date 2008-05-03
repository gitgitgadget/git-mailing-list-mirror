From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Update German translation
Date: Sat, 3 May 2008 17:53:25 +1000
Message-ID: <18460.6645.918108.615194@cargo.ozlabs.ibm.com>
References: <200805012142.10151.stimming@tuhh.de>
	<18458.65466.449698.790306@cargo.ozlabs.ibm.com>
	<200805022033.01407.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Sat May 03 10:34:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsDC1-0004jp-Ln
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 10:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbYECIdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 04:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753940AbYECIdR
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 04:33:17 -0400
Received: from ozlabs.org ([203.10.76.45]:56003 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880AbYECIdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 04:33:16 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 75762DDDEC; Sat,  3 May 2008 18:33:15 +1000 (EST)
In-Reply-To: <200805022033.01407.stimming@tuhh.de>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81061>

Christian Stimming writes:

> > Well, the commits aren't in date order, strictly speaking, and the
> > last commit isn't necessarily the oldest (though the first commit will
> > in fact be the newest).  How about:
> >
> > <Home>	Move to head of list
> > <End>	Move to tail of list
> >
> > Would that be any clearer?
> 
> I think "head of list" and "tail of list" are more the terms about the 
> implementation detail and not so much an explanation that is easily 
> understood for the user. I think some combination using the word "top" should 
> rather be used to make it really clear we're talking about the upper end of 
> the window.

The list isn't just a detail, it's what the user sees in the top pane:
the commits, listed in some order.

How about "top of list" and "bottom of list"?  Or "start of list" and
"end of list"?

Paul.
