From: Jason Spiro <jasonspiro4@gmail.com>
Subject: Setting up a bug tracking system where users can file bug reports and feature requests for Git
Date: Mon, 16 Feb 2009 02:55:33 +0000 (UTC)
Message-ID: <loom.20090216T025046-863@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 16 03:58:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYtgG-0001jV-VM
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbZBPCzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755413AbZBPCzq
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:55:46 -0500
Received: from main.gmane.org ([80.91.229.2]:51688 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409AbZBPCzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:55:46 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LYte3-0008KK-WC
	for git@vger.kernel.org; Mon, 16 Feb 2009 02:55:44 +0000
Received: from CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com ([99.226.154.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:55:43 +0000
Received: from jasonspiro4 by CPE00195b4d5e2c-CM0013718690da.cpe.net.cable.rogers.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:55:43 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 99.226.154.227 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.48 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110117>

Hi,

Is there a bug tracking system where I can file bug reports and feature 
requests for Git?  If not, could you please set up such a system?  I am more 
likely to send bug reports and feature requests to a bug tracking system than a 
mailing list, since I know that they can't be lost in the mists of time and 
forgotten forever.  :)

And if you really hate the web, and you insist on an email-centric bug tracking 
system, I know of an option for you:  "debbugs".  Both the Debian Linux 
distribution developers, and the GNU Emacs developers[1], use this system.  To 
submit a bug to debbugs, you simply send an email to the "submit@" address.  To 
add comments to a bug report, you email the "${bugnumber}@" address.  To make 
other changes, you email the "control@" address.

^  [1].  see http://emacsbugs.donarmstrong.com/emacs for a list of bugs in 
Emacs

Cheers,
--
Jason Spiro: software/web developer, packager, trainer, IT consultant.
I support Linux, UNIX, Windows, and more. Contact me to discuss your needs.
+1 (416) 992-3445 / www.jspiro.com
