From: shyamal <shyamal2005@gmail.com>
Subject: Gitk local language issue
Date: Fri, 17 Feb 2012 00:30:59 -0800 (PST)
Message-ID: <1329467459691-7293532.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 09:31:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyJDe-0007fq-AR
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 09:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab2BQIbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 03:31:00 -0500
Received: from sam.nabble.com ([216.139.236.26]:60398 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752025Ab2BQIbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 03:31:00 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <shyamal2005@gmail.com>)
	id 1RyJDX-0002eP-MX
	for git@vger.kernel.org; Fri, 17 Feb 2012 00:30:59 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190938>

Hi,

I am working in Japan now on a windows environment.
I installed GIT on my machine.When I run the application,The menus are in
Japanese.To get the English menu I added 
@set LANG=en 
at the beginning of git.cmd file.This worked like a magic :-)
But when I click the Visualize master' history from the repository menu of
Git Gui, a new interface (Gitk:Websites) opens where all the menus are still
in Japanese.Any idea how to change the menu to  English in Gitk too?

Thanks in advance

Regards,
Shyamal.

--
View this message in context: http://git.661346.n2.nabble.com/Gitk-local-language-issue-tp7293532p7293532.html
Sent from the git mailing list archive at Nabble.com.
