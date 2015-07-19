From: Ben Walton <bdwalton@gmail.com>
Subject: Adapt some tests to work around broken Solaris tools
Date: Sun, 19 Jul 2015 19:00:33 +0100
Message-ID: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, j6t@kdbg.org,
	johannes.schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 19 19:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGsrW-0000Dm-10
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 19:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816AbbGSR6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 13:58:40 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44637 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789AbbGSR6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 13:58:39 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:35482 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrG-00035y-JJ ; Sun, 19 Jul 2015 13:58:38 -0400
Received: from 86-42-134-176-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.134.176]:38623 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrF-0007f9-3X ; Sun, 19 Jul 2015 13:58:37 -0400
Received: from bdwalton by neilyoung with local (Exim 4.84)
	(envelope-from <bdwalton@benandwen.net>)
	id 1ZGstD-0004zg-2Y; Sun, 19 Jul 2015 19:00:39 +0100
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274272>

This series is a respin of the previous submission, taking feedback
into account.
