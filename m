From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: gitk: window size for Edit View, Preferences
Date: Sat, 20 Feb 2010 17:15:17 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20100220161516.GD2564@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 20 18:49:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NirzW-00065w-95
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 17:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756532Ab0BTQPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 11:15:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:43626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755205Ab0BTQPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 11:15:23 -0500
Received: (qmail invoked by alias); 20 Feb 2010 16:15:20 -0000
Received: from xdsl-89-0-180-62.netcologne.de (EHLO localhost.localdomain) [89.0.180.62]
  by mail.gmx.net (mp044) with SMTP; 20 Feb 2010 17:15:20 +0100
X-Authenticated: #13673931
X-Provags-ID: V01U2FsdGVkX1+LvPckV0WLPGwp1q6BSWH/onYoNENI9/YlQvBivl
	Heq9ds20YIGOKM
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1NirzB-0001aR-5H
	for git@vger.kernel.org; Sat, 20 Feb 2010 17:15:17 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-10-28)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140535>

I gave a short introduction to git a while ago, demonstrating
gitk from a netbook.  The "Edit View" window was not resizable
to fit on the screen, also the window manager disallowed moving
it up enough to get to the buttons adjusting the sorting.

I'm sure this is double PEBKAC (not using a good WM or configuring
it right, not adjusting font size), but still, a vertical ruler
for this and the Preferences window would be handy, and probably
a quick two-line change for somebody with less rusty Tcl/Tk than
me.  Barring a patch, I'd be glad about pointers, too.

Thanks for git and gitk!
Ralf
