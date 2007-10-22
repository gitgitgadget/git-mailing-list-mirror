From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 0/9] Bisect skip
Date: Mon, 22 Oct 2007 07:47:28 +0200
Message-ID: <200710220747.28731.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq1p-0007Lf-7c
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbXJVFk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbXJVFk2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:40:28 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:35927 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbXJVFk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:40:27 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D1E9B1AB2D1;
	Mon, 22 Oct 2007 07:40:25 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 90CB51AB2C8;
	Mon, 22 Oct 2007 07:40:25 +0200 (CEST)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61937>

Hi all,

Here is the "bisect skip" patch series.
It's just a rename from "dunno" to "skip" compared to the previous "dunno" 
patch series that was in Shawn's pu branch.

In fact there is no change in the first 3 patches and trivial changes in the 
other patches.

Thanks,
Christian.
