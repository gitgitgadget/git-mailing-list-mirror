From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 0/4] More tutorial updates
Date: Sun, 12 Oct 2008 17:11:08 +0200
Message-ID: <20081012150825.17648.3315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2cy-0004du-Cs
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbYJLPLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 11:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYJLPLc
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:11:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1045 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYJLPLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:11:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Kp2bP-0006Vz-00; Sun, 12 Oct 2008 16:11:27 +0100
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98031>

More updates to the tutorial. I'd really appreciate if people would
sanity check these; a bad tutorial tends to reflect negatively on a
project.

---

Karl Hasselstr=C3=B6m (4):
      Tutorial: Write about rebasing
      Tutorial: Cover "stg mail"
      Tutorial: Explain diffs a little bit better
      Tutorial: Talk about conflicts when introducing StGit


 Documentation/stg.txt      |    8 ++
 Documentation/tutorial.txt |  191 ++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 191 insertions(+), 8 deletions(-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
