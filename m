From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: git reset --hard w/o touching every file
Date: Sat, 01 Nov 2008 00:48:38 -0400
Message-ID: <gegn38$lku$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 05:50:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw8R6-0003E6-Pc
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 05:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbYKAEsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 00:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbYKAEsz
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 00:48:55 -0400
Received: from main.gmane.org ([80.91.229.2]:54188 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbYKAEsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 00:48:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kw8Pq-0008KH-KZ
	for git@vger.kernel.org; Sat, 01 Nov 2008 04:48:50 +0000
Received: from lily.mit.edu ([18.243.2.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 04:48:50 +0000
Received: from edwardzyang by lily.mit.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 04:48:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: lily.mit.edu
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99718>

I was wondering if there was any way to run `git reset --hard $revlike`,
or a command with the same effect, without having Git touch every file?

Cheers,
Edward
