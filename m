From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/5] Compute patch appliedness using the commit DAG
Date: Tue, 07 Aug 2007 04:47:38 +0200
Message-ID: <20070807024508.11373.62875.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF6l-0005C9-Nh
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765873AbXHGCrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765860AbXHGCrl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:47:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2234 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765835AbXHGCrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:47:40 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF6h-0002Tx-00; Tue, 07 Aug 2007 03:47:39 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55205>

This is the same old series, now rebased against 0.13. It's in my
repo.or.cz repository, so I have high hopes of tricking people into
actually trying it out so that it can be merged eventually.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
