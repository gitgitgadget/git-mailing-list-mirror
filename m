From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 0/3] stgit.el patches
Date: Thu, 30 Oct 2008 10:52:43 +0100
Message-ID: <20081030095221.10290.58637.stgit@krank>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 30 11:15:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvUYV-0007zW-8u
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 11:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbYJ3KNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2008 06:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753513AbYJ3KNs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 06:13:48 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:54116 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbYJ3KNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 06:13:45 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 9498540005;
	Thu, 30 Oct 2008 10:52:43 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 8939540036; Thu, 30 Oct 2008 10:52:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 4505040005;
	Thu, 30 Oct 2008 10:52:43 +0100 (CET)
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by krank (Postfix) with ESMTP id D4C7FDC0A4;
	Thu, 30 Oct 2008 10:52:43 +0100 (CET)
User-Agent: StGIT/0.14.3.278.g6f7d
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99452>

These three patches updates stgit.el. They don't depend on each other
and can be applied independently.

---

David K=C3=A5gedal (3):
      stgit.el: Adapt to new output from stg series.
      stgit.el: Added numeric prefix argument to push and pop commands.
      stgit.el: Added undo command


 contrib/stgit.el |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

--=20
Signature
