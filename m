From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git fsck not identifying corrupted packs
Date: Mon, 19 Oct 2009 11:11:33 +0200
Message-ID: <4ADC2D45.3020803@viscovery.net>
References: <loom.20091019T094924-194@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 11:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzoHG-0003qH-7l
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 11:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbZJSJLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 05:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbZJSJLc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 05:11:32 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36108 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbZJSJLb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 05:11:31 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MzoH8-0007TY-M0; Mon, 19 Oct 2009 11:11:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0EFC04E9; Mon, 19 Oct 2009 11:11:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <loom.20091019T094924-194@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130682>

Sergio Callegari schrieb:
> Is there a means to have fsck to a truly full check on the sanity of a repo?

git fsck --full

RTFM, please.

-- Hannes
