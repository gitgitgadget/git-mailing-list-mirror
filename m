From: Balazs Nagy <js@iksz.hu>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Mon, 11 Aug 2008 08:28:57 +0200
Message-ID: <489FDC29.5090503@iksz.hu>
References: <7vsktczebg.fsf@gitster.siamese.dyndns.org> <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, johan@herland.net
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 08:40:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSR4p-00022m-AL
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 08:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbYHKGjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 02:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbYHKGjO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 02:39:14 -0400
Received: from www.hnt.hu ([195.56.65.48]:51872 "EHLO mail.aranyoroszlan.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbYHKGjO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 02:39:14 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Aug 2008 02:39:14 EDT
Received: from localhost (mailhost [172.31.1.5])
	by mail.aranyoroszlan.hu (Postfix) with ESMTP id C8D0810FB79D;
	Mon, 11 Aug 2008 08:28:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at aranyoroszlan.hu
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 required=5 tests=[ALL_TRUSTED=-1.44,
	AWL=0.441]
Received: from mail.aranyoroszlan.hu ([172.31.1.5])
	by localhost (tcb.aranyoroszlan.hu [172.31.1.5]) (amavisd-new, port 10024)
	with ESMTP id iSGo5-XYtd-n; Mon, 11 Aug 2008 08:28:47 +0200 (CEST)
Received: from [192.168.1.101] (pool-0508.adsl.interware.hu [213.178.101.252])
	(Authenticated sender: js@iksz.hu)
	by mail.aranyoroszlan.hu (Postfix) with ESMTPA id 9BEAA10FB79C;
	Mon, 11 Aug 2008 08:28:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1218409804-1556-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91917>

Hi,

Sorry for being a bit late, but what if we would have --all for all
submodule commands instead of having another command?

Rgds,
-- 
-jul-
