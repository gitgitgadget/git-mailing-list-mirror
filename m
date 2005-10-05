From: Jon Loeliger <jdl@freescale.com>
Subject: git-show-index rename suggestion?
Date: Wed, 05 Oct 2005 15:31:20 -0500
Message-ID: <1128544279.29904.19.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 05 22:34:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENFvi-0006uk-OE
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 22:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030377AbVJEUbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVJEUbf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 16:31:35 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:33432 "EHLO
	az33egw01.freescale.net") by vger.kernel.org with ESMTP
	id S1030377AbVJEUbe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 16:31:34 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id j95Kfs69026871
	for <git@vger.kernel.org>; Wed, 5 Oct 2005 13:41:54 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j95KbYLY026205
	for <git@vger.kernel.org>; Wed, 5 Oct 2005 15:37:34 -0500 (CDT)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9730>

So, I was reading up on the various "index" operations
like git-diff-index, git-checkout-index, etc.  Things
that operated on the index.

Naturally, I was surprised when I realized "git-show-index"
has nothing to do with the index, but rather the .idx "index"
files associated with packs.

Um, git-show-pack-index?

Ducking,
jdl
