From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH 0/2] Tweaking the gitk window title.
Date: Tue,  6 Jan 2015 12:51:58 -0500
Message-ID: <1420566720-25238-1-git-send-email-marcnarc@xiplink.com>
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 19:01:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8YQq-0001Lb-La
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbbAFSAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:00:09 -0500
Received: from domain.not.configured ([192.252.130.194]:45690 "EHLO
	cubert.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932285AbbAFSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:00:08 -0500
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
	by cubert.xiplink.com (Postfix) with ESMTP id 8478F60417;
	Tue,  6 Jan 2015 12:52:12 -0500 (EST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262080>

The first patch simply changes the title from "gitk: <dir>" to "<dir> - gitk",
which is the title layout used by most of the applications on my Kubuntu box.

The second patch is the one that I'm more keen to see accepted.  It relies
on the first only in that it follows the new title layout.

		M.
