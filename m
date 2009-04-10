From: rt <rupert.thurner@gmail.com>
Subject: suggest possible commands after the file list, not before
Date: Fri, 10 Apr 2009 10:11:32 +0000 (UTC)
Message-ID: <loom.20090410T093318-984@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 08:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsWRH-0003Tk-Lj
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 08:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbZDKGKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 02:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754655AbZDKGKG
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 02:10:06 -0400
Received: from main.gmane.org ([80.91.229.2]:47998 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123AbZDKGKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 02:10:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LsWPi-0004GA-VK
	for git@vger.kernel.org; Sat, 11 Apr 2009 06:10:03 +0000
Received: from www-gw3.credit-suisse.com ([198.240.212.25])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 06:10:02 +0000
Received: from rupert.thurner by www-gw3.credit-suisse.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 06:10:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 198.240.212.25 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.6) Gecko/2009011913 Firefox/3.0.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116292>

when doing a "git init", and a "git add ." git suggests a command to undo. which
is great.

but, would it be possible to print the suggestion at the end of the list? git is
really much too fast that one can notice this at the beginning.

rupert
