From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/3] revisions.txt improvements
Date: Mon,  4 Apr 2011 17:27:02 +0200
Message-ID: <cover.1301930700.git.git@drmicha.warpmail.net>
References: <cover.1301649867.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 17:30:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6ljv-0007w7-IL
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 17:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749Ab1DDPak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 11:30:40 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35844 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698Ab1DDPaj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 11:30:39 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 135C520A51;
	Mon,  4 Apr 2011 11:30:39 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 Apr 2011 11:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=LdSaL9ZTm3Rp43Njc3ck0xeO+Fk=; b=oS0VSb+Me55WEBcT+lKaMATNm0sxFL/Ky86N14pNsi6oeTT62TBHna011USk5XSoJRBaJtSSG1cdVCvOXlrdSB7ipOdMkizxjRrMLaLjNzOYY2gnypyprM7gcEcz6WHQbJGd/vRHtt26/U9euvaWk0j/471hii1LLNhYFV+SiO4=
X-Sasl-enc: wrGDGFxVlUNzM/DdJryUVlk580IyU7T3qBxWNGrhMFBi 1301931038
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 89BDF440FDE;
	Mon,  4 Apr 2011 11:30:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.2.668.gba03a4
In-Reply-To: <cover.1301649867.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170818>

v3 as per discussion with Junio.
(1/3, 2/3 unchanged but resent)

Michael J Gruber (3):
  revisions.txt: consistent use of quotes
  revisions.txt: structure with a labelled list
  revisions.txt: language improvements

 Documentation/revisions.txt |  198 +++++++++++++++++++++++--------------------
 1 files changed, 107 insertions(+), 91 deletions(-)

-- 
1.7.4.2.668.gba03a4
