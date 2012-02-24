From: supadhyay <supadhyay@imany.com>
Subject: cvs2git multiple session for repository migration...
Date: Fri, 24 Feb 2012 06:08:44 -0800 (PST)
Message-ID: <1330092524040-7314909.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 15:08:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0vpJ-0006vt-R7
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 15:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab2BXOIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 09:08:45 -0500
Received: from sam.nabble.com ([216.139.236.26]:50084 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330Ab2BXOIp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 09:08:45 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <supadhyay@imany.com>)
	id 1S0vpE-0002Qk-3X
	for git@vger.kernel.org; Fri, 24 Feb 2012 06:08:44 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191435>

Hi All,


I am migrating my CVS repository to GIt. As I have multiple repository I
want to start multiple session for cvs2git,but it failed to start. I
received cvs2svn.lock file error ? Is there any workaround to start multiple
cvs2git session (which migrate the CVS directory) ??

Thanks in advance...

--
View this message in context: http://git.661346.n2.nabble.com/cvs2git-multiple-session-for-repository-migration-tp7314909p7314909.html
Sent from the git mailing list archive at Nabble.com.
