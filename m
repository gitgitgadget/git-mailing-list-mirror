From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [RFC PATCH 0/2] Teach how to discard changes in the working directory
Date: Mon,  8 Sep 2008 00:05:01 +0200
Message-ID: <1220825103-19599-1-git-send-email-mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 00:06:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcSOc-0007gh-9M
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 00:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920AbYIGWFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 18:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbYIGWFG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 18:05:06 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:33295 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbYIGWFG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 18:05:06 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1E3EE1406D
	for <git@vger.kernel.org>; Mon,  8 Sep 2008 00:05:07 +0200 (CEST)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id C2C891405A
	for <git@vger.kernel.org>; Mon,  8 Sep 2008 00:05:06 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1.dirty
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95181>


Using "git checkout" to undo local changes is a hint that is often
given in #git. This patch (part 2) adds the hint into the status
output. A bit of restructuring appears in the initial patch.

This is merely an RFC, I am not sure whether I like it myself :-).


Anders.
