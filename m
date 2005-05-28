From: Ingo Molnar <mingo@elte.hu>
Subject: Re: gitk-1.0 released
Date: Sat, 28 May 2005 13:47:27 +0200
Message-ID: <20050528114727.GA1812@elte.hu>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 13:46:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbzlB-0001Ok-Gf
	for gcvg-git@gmane.org; Sat, 28 May 2005 13:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVE1Lry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 07:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVE1Lry
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 07:47:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:18360 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262709AbVE1Lrx (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 07:47:53 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id AC298323721;
	Sat, 28 May 2005 13:46:04 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id EE2A31FC2; Sat, 28 May 2005 13:47:43 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


another small bug: if you click into the main window _before_ the commit 
list has been fully generated (i.e. into the empty window) then all 
sorts of error messages pop up. ("Cant use empty string ...")

	Ingo
