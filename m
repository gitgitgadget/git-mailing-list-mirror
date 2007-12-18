From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Teach diff machinery to display other prefixes than
 "a/" and "b/"
Date: Tue, 18 Dec 2007 11:55:27 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712181155030.21557@woody.linux-foundation.org>
References: <1197992574-3464-1-git-send-email-pascal@obry.net> <4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net> <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org> <Pine.LNX.4.64.0712181703560.23902@racer.site> <476809EA.6080608@obry.net>
 <Pine.LNX.4.64.0712181855020.23902@racer.site> <alpine.LFD.0.9999.0712181059220.21557@woody.linux-foundation.org> <Pine.LNX.4.64.0712181930130.23902@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, Pascal Obry <pascal@obry.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 20:57:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4iYj-0005bM-Tk
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 20:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbXLRT4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 14:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbXLRT4e
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 14:56:34 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41335 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751285AbXLRT4d (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 14:56:33 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBIJtRhV001945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Dec 2007 11:55:29 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBIJtRmi018976;
	Tue, 18 Dec 2007 11:55:27 -0800
In-Reply-To: <Pine.LNX.4.64.0712181930130.23902@racer.site>
X-Spam-Status: No, hits=-3.214 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68799>



On Tue, 18 Dec 2007, Johannes Schindelin wrote:
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

		Linus
