From: dm2000 <david.matuszak@yahoo.com>
Subject: UsrClass.dat Permission denied (Windows 7)
Date: Sun, 12 Jun 2011 22:06:05 -0700 (PDT)
Message-ID: <1307941565243-6469046.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 07:06:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVzLo-0007cm-Rj
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 07:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769Ab1FMFGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 01:06:08 -0400
Received: from sam.nabble.com ([216.139.236.26]:34998 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876Ab1FMFGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 01:06:05 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <david.matuszak@yahoo.com>)
	id 1QVzLh-0002oc-8N
	for git@vger.kernel.org; Sun, 12 Jun 2011 22:06:05 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175683>

Hello,

I am new to Git... I did a quick search on here and as well as google but
couldn't find a similar issue that others were having. 

I am studying Ruby on Rails and having problems with the initial setup of
Git on my machine. Basically, I am trying to edit the .gitignore file.
However, when I enter: 'git add .' it results in the following:

error: open("appdata/local/microsoft/windows/usrclass.dat"): Permission
Denied
error: unable to index file appdata/local/microsoft/windows/usrclass.dat
fatal: adding files failed

Any idea how to correct this?

--
View this message in context: http://git.661346.n2.nabble.com/UsrClass-dat-Permission-denied-Windows-7-tp6469046p6469046.html
Sent from the git mailing list archive at Nabble.com.
