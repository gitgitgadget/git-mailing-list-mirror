From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFH] What do you think about adding graphical merge to git-gui?
Date: Sat, 8 Mar 2008 12:19:10 +1100
Message-ID: <18385.59790.276210.858893@cargo.ozlabs.ibm.com>
References: <200803071240.09999.jnareb@gmail.com>
	<200803071446.39468.jnareb@gmail.com>
	<alpine.LSU.1.00.0803071453160.19395@racer.site>
	<200803071621.37376.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 08 02:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXnjC-0005iU-4G
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 02:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853AbYCHBTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 20:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbYCHBTT
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 20:19:19 -0500
Received: from ozlabs.org ([203.10.76.45]:55177 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbYCHBTT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 20:19:19 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 49A3FDDF20; Sat,  8 Mar 2008 12:19:16 +1100 (EST)
In-Reply-To: <200803071621.37376.jnareb@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76534>

Jakub Narebski writes:

> Could you recommend some good (best if also free) documentation of 
> Tcl/Tk, so I won't be doing "cargo cult" (copy'n'paste) programming?

Tcl/Tk normally comes with an extensive set of man pages.  Under
Debian there are tcl8.5-doc and tk8.5-doc packages, for instance, that
contain the man pages.  If you have them installed you can do "man
Tcl" to get an overview of the language, or "man lsearch" if you want
to find out the arguments, options and semantics for the lsearch
command, or "man canvas" if you want to know what the canvas widget
can do, and so on.

Paul.
