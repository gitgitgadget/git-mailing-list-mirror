From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Shell script cleanups/style changes?
Date: Thu, 2 Aug 2007 20:13:15 +0200
Message-ID: <20070802181315.GE2431@uranus.ravnborg.org>
References: <86bqdqkygp.fsf@lola.quinscape.zz> <f158199e0708020748o5cac4505ic76bfb39f25ab1f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Bradford Smith <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 20:12:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGf9y-0002RO-Rr
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 20:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbXHBSM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 14:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753771AbXHBSM1
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 14:12:27 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:37743 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbXHBSM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 14:12:27 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 55E86801AC0;
	Thu,  2 Aug 2007 20:11:57 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 12D2E580D2; Thu,  2 Aug 2007 20:13:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f158199e0708020748o5cac4505ic76bfb39f25ab1f8@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54581>

> 
> Obviously, you aren't too concerned about 1 (the cost to you), because
> you're willing to do that work.  However, if I were Junio, I wouldn't
> be willing to "spend" costs 2 and 3 on a patch that didn't either fix
> a problem or provide a new feature.

For any decent codebase there is a need to keep the code clean.
Being part of the linux-kernel community we see clean-up patches 
each day and a lot are applied.
Even spelling errors in comments are sometimes applied.

Do not underestimate the value of a clean codebase.

	Sam
