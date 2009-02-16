From: Jason Spiro <jasonspiro4@gmail.com>
Subject: Please make hooks installed executable either on all platforms or on no platforms at all
Date: Mon, 16 Feb 2009 02:24:51 +0000 (UTC)
Message-ID: <loom.20090216T022127-960@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 03:32:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtHA-0005Op-Pf
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755401AbZBPCaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755375AbZBPCaF
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:30:05 -0500
Received: from main.gmane.org ([80.91.229.2]:48342 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755365AbZBPCaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:30:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LYtFC-0007R4-EF
	for git@vger.kernel.org; Mon, 16 Feb 2009 02:30:02 +0000
Received: from CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com ([99.226.154.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:30:02 +0000
Received: from jasonspiro4 by CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.226.154.227 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110112>

In http://www.cygwin.com/ml/cygwin/2007-08/msg00260.html Eric Blake pointed out 
that on Cygwin, /usr/share/git-core/templates are installed with executable 
permissions; whereas on Linux, they are installed without.  This is 
inconsistent.  Could you please make it so they are installed executable on 
*all* platforms or on *no* platforms?

Thanks,
--
Jason Spiro: software/web developer, packager, trainer, IT consultant.
I support Linux, UNIX, Windows, and more. Contact me to discuss your needs.
+1 (416) 992-3445 / www.jspiro.com
