From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Tiny default fonts in gitk
Date: Fri, 11 Aug 2006 12:07:06 +0200
Message-ID: <20060811100706.GA22767@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 11 12:07:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBTvF-0004vD-Fl
	for gcvg-git@gmane.org; Fri, 11 Aug 2006 12:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWHKKHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 06:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWHKKHM
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 06:07:12 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:64133 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751093AbWHKKHL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 06:07:11 -0400
Received: (qmail 24825 invoked by uid 5842); 11 Aug 2006 12:07:06 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25222>

Hi list,

I find the default font for gitk too small to be readable on my 1280x800
pixels resolution.  This is an extract from the file, .gitk, that gitk
initially creates:

set mainfont {Helvetica 9}
set textfont {Courier 9}
set uifont {Helvetica 9 bold}

Is it just some X/Tk setting causing this, or is point 9 just very
small?  This is under Fedora Core 5.  Changing these sizes to 12 gives
the text the same size as in the rest of the desktop.  It would be nice,
if that was the default.

Regards,

Peter
