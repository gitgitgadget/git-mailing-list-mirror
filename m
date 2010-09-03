From: Gelonida <gelonida@gmail.com>
Subject: create easy to parse list of added / ,odified files
Date: Fri, 03 Sep 2010 08:36:52 +0200
Message-ID: <i5q524$9fc$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 03 08:37:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrPto-0000LQ-IT
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 08:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab0ICGhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 02:37:06 -0400
Received: from lo.gmane.org ([80.91.229.12]:44729 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752124Ab0ICGhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 02:37:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OrPtW-0000AY-Qs
	for git@vger.kernel.org; Fri, 03 Sep 2010 08:37:02 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 08:37:02 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 08:37:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 ""
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155236>

Hi,


for a pre-commit trigger I would like to retrieve the list of modified
files, such, that I could analyze the contents prior to commit.

what would be the best command for this


I thought about using "git status", but wondered, which other command
might return a nicer to parse list.

TIA
