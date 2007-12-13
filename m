From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [egit] How-to use egit
Date: Fri, 14 Dec 2007 00:24:20 +0100
Message-ID: <200712140024.20667.robin.rosenberg.lists@dewire.com>
References: <476032A2.9010308@saville.com> <20071213024735.GB7492@fawkes> <4761B3B2.4040807@saville.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 00:22:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2xO5-00009E-CQ
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 00:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759689AbXLMXWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 18:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbXLMXWQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 18:22:16 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12469 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759689AbXLMXWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 18:22:16 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 863D2802AB1;
	Fri, 14 Dec 2007 00:12:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bm6vESodwXQR; Fri, 14 Dec 2007 00:12:45 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 15B568028A1;
	Fri, 14 Dec 2007 00:12:43 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <4761B3B2.4040807@saville.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68200>

torsdag 13 december 2007 skrev Wink Saville:
> Yes, I selected them all and a single jar was created which
Never seen that behaviour. I'm surprised that would be the default.
When I export I get separate jars.

> I then started eclipse and now I see: Window/Preferences/Team/Git
> When I select "Git" in the above, I see "Hi, I'm an empty preference page."
That's all there is for now, but it means the plugin is activated.

> But again, I don't see any new menu items that
> would allow me to look at history or make commits.
> Is there more I need to to install the plugin, or
> maybe I just need a little guidance on how to use it.

We do not actually implement any menus in the menu bar. The only menus
are in the context (right click) menu on resources.

Try right-click on a project in the project explorer and the Team menu>Share project.

-- robin
