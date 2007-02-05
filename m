From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: MinGW port now supports native git protocol
Date: Mon, 05 Feb 2007 10:03:50 +0100
Organization: eudaptics software gmbh
Message-ID: <45C6F2F6.ADFE0A13@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 10:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDzkA-0004Ne-3L
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 10:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbXBEJCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 04:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbXBEJCV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 04:02:21 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160]:17961 "EHLO
	linz.eudaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbXBEJCU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 04:02:20 -0500
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id 9A9226D9
	for <git@vger.kernel.org>; Mon,  5 Feb 2007 10:02:17 +0100 (CET)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38733>

Thanks to H. Peter Anvin's tips, the MinGW port now also supports clone,
fetch, pull via the native git protocol. Visit

gitweb:     http://repo.or.cz/w/git/mingw.git
Clone/pull: git://repo.or.cz/git/mingw.git
A Readme:
http://repo.or.cz/w/git/mingw.git?a=blob_plain;f=README.MinGW;hb=master

Please try branch 'master' first, and if this does not compile or does
not work in some way, try branch 'devel', which contains a few extra
patches that I need on my system to make it work.

If you want to contribute, please consider using the 'mob' branch (see
the gitweb summary page). Base your contributions on 'master'.

-- Hannes
