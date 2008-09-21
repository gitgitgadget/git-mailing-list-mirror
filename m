From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/2] stg delete --spill
Date: Sun, 21 Sep 2008 21:07:24 +0200
Message-ID: <20080921190708.4503.20574.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 21:09:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhUIp-0001mK-Ok
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 21:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbYIUTHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 15:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbYIUTHa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 15:07:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3157 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbYIUTHa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 15:07:30 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KhUcl-0003ZY-00; Sun, 21 Sep 2008 20:29:39 +0100
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96426>

---

Karl Hasselstr=C3=B6m (2):
      Test the new stg delete --spill flag
      Add a new flag, --spill, to stg delete


 stgit/commands/delete.py |   13 +++++++++++++
 t/t1602-delete-spill.sh  |   47 ++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100755 t/t1602-delete-spill.sh

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
