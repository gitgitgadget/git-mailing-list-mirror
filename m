From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] Two small doc fixes
Date: Sun, 25 Nov 2007 21:35:21 +0100
Message-ID: <20071125203346.7640.80801.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:35:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOCm-0007T8-22
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbXKYUfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756174AbXKYUfc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:35:32 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1260 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbXKYUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:35:31 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOCM-0007ST-00; Sun, 25 Nov 2007 20:35:26 +0000
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65987>

---

Also available from

  git://repo.or.cz/stgit/kha.git safe

Karl Hasselstr=C3=B6m (2):
      Add missing switch to "stg uncommit" usage line
      Push and pop don't have --to flags anymore


 stgit/commands/goto.py     |    5 ++---
 stgit/commands/uncommit.py |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
