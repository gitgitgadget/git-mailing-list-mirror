From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 0/5] gitweb: Support for arbitrary diffs
Date: Mon, 03 Sep 2007 13:22:56 +0100
Message-ID: <tnxodgkuee7.fsf@arm.com>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Sep 03 14:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISAxb-0000yI-8j
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 14:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbXICMXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 08:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbXICMXO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 08:23:14 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45215 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751332AbXICMXO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2007 08:23:14 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l83CMwO0024041;
	Mon, 3 Sep 2007 13:22:58 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 3 Sep 2007 13:22:57 +0100
In-Reply-To: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> (Martin
 Koegler's message of "Sun,  2 Sep 2007 16:46:03 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 03 Sep 2007 12:22:57.0764 (UTC) FILETIME=[294FBA40:01C7EE25]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57477>

Martin Koegler <mkoegler@auto.tuwien.ac.at> wrote:
> I develop the patches via StGit. If you think that I should publish them
> in a different way, please tell me.

You could use 'stg mail' to send the patches and it makes each patch a
direct child of the main series description (PATCH 0/5) rather than a
child of the previous patch. It looks nicer with a threaded view.

-- 
Catalin
