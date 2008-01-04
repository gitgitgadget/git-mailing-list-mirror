From: William Morgan <wmorgan-git@masanjin.net>
Subject: git-walkthrough-add script
Date: Thu, 03 Jan 2008 22:14:31 -0800
Message-ID: <1199426431-sup-6092@south>
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 07:28:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAg33-0007fg-Q5
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 07:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbYADG2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 01:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753676AbYADG2S
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 01:28:18 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:3232 "EHLO
	nlpi015.prodigy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbYADG2S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 01:28:18 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2008 01:28:18 EST
X-ORBL: [68.127.149.88]
Received: from south (adsl-68-127-149-88.dsl.pltn13.pacbell.net [68.127.149.88])
	by nlpi015.prodigy.net (8.13.8 out.dk.spool/8.13.8) with ESMTP id m046Kj3J006399
	for <git@vger.kernel.org>; Fri, 4 Jan 2008 00:20:45 -0600
Received: from rubyist by south with local (Exim 4.63)
	(envelope-from <rubyist@masanjin.net>)
	id 1JAfp9-0004Ze-3P
	for git@vger.kernel.org; Thu, 03 Jan 2008 22:14:31 -0800
User-Agent: Sup/0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69552>

Hi all,

I've written a little script to do darcs-style hunk-by-hunk
walkthroughs. It's based on the git-hunk-commit script that was floating
around. Maybe someone else will find it useful.

http://git-wt-commit.rubyforge.org/

-- 
William <wmorgan-git@masanjin.net>
