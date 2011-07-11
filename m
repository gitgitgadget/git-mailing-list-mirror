From: frankkany <frankkany@gmail.com>
Subject: Re: git remote show origin (URL)
Date: Mon, 11 Jul 2011 10:10:55 -0700 (PDT)
Message-ID: <1310404255063-6571752.post@n2.nabble.com>
References: <1310400505376-6571492.post@n2.nabble.com> <CA+gHt1AxfgB=zJ2hVZ-7gZzyPFDuTyFW_NqiepobTWHRsafAhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 19:11:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgK0c-0008SW-2Z
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 19:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757988Ab1GKRK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 13:10:57 -0400
Received: from sam.nabble.com ([216.139.236.26]:40767 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757967Ab1GKRK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 13:10:56 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <frankkany@gmail.com>)
	id 1QgK0V-0004ZV-94
	for git@vger.kernel.org; Mon, 11 Jul 2011 10:10:55 -0700
In-Reply-To: <CA+gHt1AxfgB=zJ2hVZ-7gZzyPFDuTyFW_NqiepobTWHRsafAhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176873>

Running:
"git config -l"

Shows the same URL displayed in when running: 
"git remote show origin"

I also checked the /etc/hosts file to make sure "hidden-repos" didn't point
to another IP.

I'm stumped...

--
View this message in context: http://git.661346.n2.nabble.com/git-remote-show-origin-URL-tp6571492p6571752.html
Sent from the git mailing list archive at Nabble.com.
