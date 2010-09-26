From: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Subject: What happens if someone modifies repository without me knowing?
Date: Sun, 26 Sep 2010 21:07:29 +0200
Message-ID: <i7o5rc$t3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 21:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozwcd-0008Af-T7
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 21:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757421Ab0IZTKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 15:10:47 -0400
Received: from lo.gmane.org ([80.91.229.12]:41083 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757090Ab0IZTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 15:10:46 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OzwcW-000884-PU
	for git@vger.kernel.org; Sun, 26 Sep 2010 21:10:44 +0200
Received: from p4fd4a171.dip0.t-ipconnect.de ([79.212.161.113])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 21:10:44 +0200
Received: from Manuel.Spam by p4fd4a171.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 21:10:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p4fd4a171.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.13) Gecko/20100916 SeaMonkey/2.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157253>

Hello,

let's assume someone got access to the GIT server of my hoster and tries 
to hide a change within an old commit, done by me.

How will GIT tell me about this hidden change? Will a "git pull" just 
bring this change into my working copy, whithout telling me about the 
change?

Yours

Manuel
