From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH 0/2] Two minor fixes for vc-git
Date: Sun, 22 Oct 2006 20:41:08 +0200
Message-ID: <20061022184108.4093.65651.stgit@localhost>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 20:46:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbiLA-00070C-1e
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 20:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWJVSq3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 14:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWJVSq3
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 14:46:29 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:3048 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1750806AbWJVSq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 14:46:28 -0400
Received: from ironport2.bredband.com ([195.54.107.84] [195.54.107.84])
          by mxfep02.bredband.com with ESMTP
          id <20061022184626.TOCN2091.mxfep02.bredband.com@ironport2.bredband.com>
          for <git@vger.kernel.org>; Sun, 22 Oct 2006 20:46:26 +0200
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO yoghurt.hemma.treskal.com) ([83.227.180.148])
  by ironport2.bredband.com with ESMTP; 22 Oct 2006 20:46:26 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by yoghurt.hemma.treskal.com (Postfix) with ESMTP id 1B8544C010;
	Sun, 22 Oct 2006 20:46:26 +0200 (CEST)
To: Alexandre Julliard <julliard@winehq.org>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29771>

I'm a total newbie when it comes to elisp, so you may want to take
these with a pinch of salt. But vc-git was quite broken for me without
this fix, so I guess _something_ has to be done about it ...

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
