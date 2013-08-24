From: Kacper Kornet <draenog@pld-linux.org>
Subject: [PATCH 0/3] Fixes for tests run without perl
Date: Sat, 24 Aug 2013 06:01:43 +0200
Message-ID: <1377316906-70338-1-git-send-email-draenog@pld-linux.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 06:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD53F-0002Bv-Ab
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 06:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab3HXEB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 00:01:56 -0400
Received: from carme.pld-linux.org ([193.239.45.140]:59351 "EHLO
	carme.pld-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107Ab3HXEB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Aug 2013 00:01:56 -0400
Received: from draenog by carme.pld-linux.org with local (Exim 4.80.1)
	(envelope-from <draenog@carme.pld-linux.org>)
	id 1VD52w-000IWD-NR
	for git@vger.kernel.org; Sat, 24 Aug 2013 06:01:54 +0200
X-Mailer: git-send-email 1.8.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232863>

This is a set of fixes for problems found while running
test suite without perl installed.

Kacper
