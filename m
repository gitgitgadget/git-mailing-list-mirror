From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Some updates to refspec documentation
Date: Wed, 29 Oct 2008 21:25:38 +0100
Message-ID: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:27:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHd7-0005zb-T3
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbYJ2UZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYJ2UZv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:51 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42688 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230AbYJ2UZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:48 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id D98DE1406D;
	Wed, 29 Oct 2008 21:25:48 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 9F9AE1405A;
	Wed, 29 Oct 2008 21:25:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99403>


I have skimmed the git-push manpage many times over a period of
several months, without fully understanding it. Today I sat down and
figured it out. It took some experiments and a little reading of the
source.

Here I offer some updates to the refspec documentation, so that others
can hopefully learn it faster than I did. As I expect some changes to
be more controversial than others, I have split it up in several small
parts. Feel free to squash.

There is a risk that I have changed some things to be wrong. I wanted
to make this update while I was still a frustrated newbie.



Anders
