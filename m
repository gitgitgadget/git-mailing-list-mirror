From: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: [PATCH 0/7] cleanups: intro
Date: Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
Message-ID: <20060417145148.2F3CB19C90D@sergelap.hallyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 17 17:15:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVVRL-0006b0-0f
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 17:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWDQPOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 11:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWDQPOt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 11:14:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60361 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751084AbWDQPOt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 11:14:49 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k3HFEmjN010981
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k3HFEmkk238870
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3HFEmlE017230
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: from sergelap.hallyn.com ([9.49.218.134])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k3HFEmu9017216
	for <git@vger.kernel.org>; Mon, 17 Apr 2006 11:14:48 -0400
Received: by sergelap.hallyn.com (Postfix, from userid 1000)
	id C303B19B90D; Mon, 17 Apr 2006 10:14:47 -0500 (CDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Mutt-Fcc: =SENT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18828>

While debating whether to run git-daemon at home, I figured I'd
run some static analysis on the source.  The following patches
are all pretty trivial, addressing things the tool pointed out.

thanks,
-serge
