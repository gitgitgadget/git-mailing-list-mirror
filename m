From: Denis Shaposhnikov <dsh@wizard.volgograd.ru>
Subject: how to apply diff between A and B to a file?
Date: Mon, 25 Feb 2008 21:43:26 +0300
Message-ID: <20080225214326.353d0e95@wizard.volgograd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 19:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTiJ9-0005Zq-EF
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 19:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbYBYSnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 13:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755250AbYBYSnf
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 13:43:35 -0500
Received: from alias.rigel.internal.vlink.ru ([85.172.168.14]:54285 "EHLO
	sagitta.internal.vlink.ru" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755214AbYBYSne (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 13:43:34 -0500
Received: from sagitta.internal.vlink.ru (localhost [127.0.0.1])
	by sagitta.internal.vlink.ru (Postfix) with ESMTP id B02E41F4920
	for <git@vger.kernel.org>; Mon, 25 Feb 2008 21:43:31 +0300 (MSK)
Received: from localhost (wizard.vlink.ru [85.172.168.67])
	by sagitta.internal.vlink.ru (Postfix) with ESMTPSA id CA6BC1F48C7
	for <git@vger.kernel.org>; Mon, 25 Feb 2008 21:43:30 +0300 (MSK)
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; i386-portbld-freebsd6.3)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75042>

Hello,

With svn I used a command "svn merge -r A:B some/file" to apply diff
between revisions A and B to file some/file. I done it in one branch,
in trunk for example. Is it possible to do such thing with git?

Thanks!

-- 
DSS5-RIPE DSS-RIPN mailto:dsh@wizard.volgograd.ru xmpp:dsh@vlink.ru
http://wizard.volgograd.ru/ 2:550/5068@fidonet 2:550/5069@fidonet
