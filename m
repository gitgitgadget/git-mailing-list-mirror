From: Jesse van den Kieboom <jesse@icecrew.nl>
Subject: git gtk+/GNOME gui application: gitg
Date: Sat, 31 Jan 2009 21:05:17 +0100
Message-ID: <1233432317.26364.5.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 11:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUIcf-0001Wm-SC
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 11:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbZBCKds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 05:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbZBCKds
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 05:33:48 -0500
Received: from novowork.com ([87.230.85.62]:43109 "EHLO novowork.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750998AbZBCKds (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 05:33:48 -0500
X-Greylist: delayed 4733 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Feb 2009 05:33:47 EST
Received: from [192.168.3.101] (217-162-71-67.dclient.hispeed.ch [217.162.71.67])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by novowork.com (Postfix) with ESMTPSA id DB7F7367064C
	for <git@vger.kernel.org>; Sat, 31 Jan 2009 21:05:18 +0100 (CET)
X-Mailer: Evolution 2.24.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108174>

Hi,

I have been developing a gui application for git for gtk+/GNOME based on
GitX (which in turn is based on gitk). I feel that it's reaching the
point where it might potentially be useful for other people to use. It
currently features:

- Loading large repositories very fast
- Show/browse repository history
- Show highlighted revision diff
- Browse file tree of a revision and export by drag and drop
- Search in the revision history on subject, author or hash
- Switch between history view of branches easily
- Commit view providing per hunk stage/unstage and commit

The project is currently hosted on github:
http://github.com/jessevdk/gitg

clone: git://github.com/jessevdk/gitg.git

Please let me know what you think,


With kind regards,

-- 
Jesse van den Kieboom

Personal: http://www.icecrew.nl
Professional: http://www.novowork.com
