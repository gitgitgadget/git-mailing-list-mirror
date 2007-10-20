From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk patch collection pull request
Date: Sat, 20 Oct 2007 21:46:23 +1000
Message-ID: <18201.60047.898077.579869@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<18200.36704.936554.220173@cargo.ozlabs.ibm.com>
	<531A500E-667F-413C-BD20-D23DC817EB72@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 14:17:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjDD3-00014O-EW
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 14:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758776AbXJTLqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 07:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758892AbXJTLqa
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 07:46:30 -0400
Received: from ozlabs.org ([203.10.76.45]:48130 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758581AbXJTLq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 07:46:29 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id CED8DDDEB6; Sat, 20 Oct 2007 21:46:28 +1000 (EST)
In-Reply-To: <531A500E-667F-413C-BD20-D23DC817EB72@steelskies.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61826>

Jonathan del Strother writes:

> In my defense, most of that file is space indented, and the places  

Only the lines that are indented 1 level start with spaces.  Any line
that is indented 2 or more levels should start with a tab.

> that are tab indented are generally totally broken unless you have an  
> 8 char tab width.

So set your tabs to 8 spaces when looking at it. :)

> It seems to have the whole 'tabs for code  
> indentation, with space for alignment' rule back-to-front.

I don't recall signing up to that rule. :)  I use 4-column indentation
and 8-column tabs, and my editor (emacs) handles it all automatically
for me.

Paul.
