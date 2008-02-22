From: Denis Shaposhnikov <dsh@wizard.volgograd.ru>
Subject: post-receive-email: about diff
Date: Fri, 22 Feb 2008 19:14:02 +0300
Message-ID: <20080222191402.5f546aed@wizard.volgograd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 17:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSafD-0006ia-Mi
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 17:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbYBVQVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 11:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754851AbYBVQVm
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 11:21:42 -0500
Received: from alias.rigel.internal.vlink.ru ([85.172.168.14]:51794 "EHLO
	sagitta.internal.vlink.ru" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754713AbYBVQVl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 11:21:41 -0500
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Feb 2008 11:21:41 EST
Received: from sagitta.internal.vlink.ru (localhost [127.0.0.1])
	by sagitta.internal.vlink.ru (Postfix) with ESMTP id 043FE1F4A8B
	for <git@vger.kernel.org>; Fri, 22 Feb 2008 19:14:05 +0300 (MSK)
Received: from localhost (wizard.vlink.ru [85.172.168.67])
	by sagitta.internal.vlink.ru (Postfix) with ESMTPSA id B77A41F4A86
	for <git@vger.kernel.org>; Fri, 22 Feb 2008 19:14:04 +0300 (MSK)
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; i386-portbld-freebsd6.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74732>

Hello,

Does somebody has modifications for contrib/hooks/post-receive-email to
send a diff together with a log message in a email?

Thanks!

-- 
DSS5-RIPE DSS-RIPN mailto:dsh@wizard.volgograd.ru xmpp:dsh@vlink.ru
http://wizard.volgograd.ru/ 2:550/5068@fidonet 2:550/5069@fidonet
