From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/2] Branch renaming bugfix
Date: Thu, 09 Aug 2007 00:56:29 +0200
Message-ID: <20070808225522.17114.3065.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:56:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIuSD-0002mW-Lb
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760572AbXHHW4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbXHHW4c
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:56:32 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1828 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184AbXHHW4c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:56:32 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIuS6-0006In-00; Wed, 08 Aug 2007 23:56:30 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55388>

This series consists of a test that demonstrates a bug in the branch
renaming (failure to rename the branch.<branchname>.stgit section),
and a fix.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
