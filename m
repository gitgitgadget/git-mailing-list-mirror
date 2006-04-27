From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Two gitweb feature requests
Date: Thu, 27 Apr 2006 14:47:06 +0100
Message-ID: <1146145626.11909.452.camel@pmac.infradead.org>
References: <1146144425.11909.450.camel@pmac.infradead.org>
	 <E1FZ6eM-0000qC-HH@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 27 15:48:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ6q2-0004WV-ST
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 15:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWD0NrU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 09:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWD0NrU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 09:47:20 -0400
Received: from canuck.infradead.org ([205.233.218.70]:47022 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S965068AbWD0NrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 09:47:19 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FZ6pq-0003br-G8; Thu, 27 Apr 2006 09:47:17 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FZ6eM-0000qC-HH@moooo.ath.cx>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19234>

On Thu, 2006-04-27 at 15:35 +0200, Matthias Lederhofer wrote:
> An easy way to do this is to put the git repository on the webserver
> and tell the webserver to redirect to gitweb if the directory is
> accessed directly, not a file in the git directory.

That's true, but isn't it much to use git:// instead of the 'dumb'
http:// method?

-- 
dwmw2
