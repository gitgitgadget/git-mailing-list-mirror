From: Sebastian Pipping <webmaster@hartwork.org>
Subject: git-daemon in IPv4 and IPv6 mode
Date: Fri, 30 Oct 2009 22:10:24 +0100
Message-ID: <4AEB5640.1010708@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robert Buchholz <rbu@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 30 22:10:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3yk9-0001A9-66
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbZJ3VKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932861AbZJ3VKX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:10:23 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:45351 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847AbZJ3VKW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:10:22 -0400
Received: from [85.177.90.113] (helo=[192.168.0.3])
	by smtprelay05.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1N3yjp-0001Ya-H2; Fri, 30 Oct 2009 22:10:25 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20091018)
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131750>

hello!


it seems like the git daemon cannot bind to both IPv4 and IPv6 at the
same time, yet.  if that's true either ipv4 or ipv6 people are standing
in the rain unless i run two instances of the daemon in parallel.

is supporting both in a single instance planned or possible already?  if
so: how?

thanks in advance,



sebastian
