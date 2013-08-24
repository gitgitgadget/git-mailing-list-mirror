From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 0/3] Fixes for tests run without perl
Date: Sat, 24 Aug 2013 05:30:29 +0200
Message-ID: <1377315030-22668-1-git-send-email-draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 05:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD4uu-0004XY-Dh
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 05:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab3HXDxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 23:53:31 -0400
Received: from carme.pld-linux.org ([193.239.45.140]:58669 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3HXDx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 23:53:29 -0400
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1VD4Yp-0008DR-AV
	for git@vger.kernel.org; Sat, 24 Aug 2013 05:30:47 +0200
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232858>

This is a set of fixes for problems found while running
test suite without perl installed.

Kacper
