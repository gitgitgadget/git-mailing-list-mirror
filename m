From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 07:37:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
References: <200701192148.20206.johannes.sixt@telecom.at>
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian MICHON <christian.michon@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9NiP-0000GN-Sr
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbXAWPhj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbXAWPhj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:37:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33898 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001AbXAWPhi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:37:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0NFbG3U006911
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Jan 2007 07:37:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0NFbFiP023189;
	Tue, 23 Jan 2007 07:37:15 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.838 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37534>



On Tue, 23 Jan 2007, Johannes Schindelin wrote:
> 
> Lucky you! Fortunately, I don't have any Windows at home (but I still have 
> windows, thank God!). So I cannot even be tempted to work on this thing in 
> my free time.

Actually, I have been seriously wondering if there is some setup under 
Wine that I could run, just so that I'd see the Windows development 
environment for git.

Has anybody tried anything like that? 

		Linus
