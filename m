From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/2] New and improved tests
Date: Tue, 07 Aug 2007 04:43:45 +0200
Message-ID: <20070807024147.11174.87229.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF31-0004VF-43
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765759AbXHGCns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765673AbXHGCns
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:43:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2222 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765671AbXHGCnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:43:47 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF2w-0002Sm-00; Tue, 07 Aug 2007 03:43:46 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55202>

One new and one improved test, both primarily useful for making sure
the DAG pseries doesn't break anything, since no one else has managed
to produce bugs that mess up the patch order.

This far. So they might be worth having anyway. :-)

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
