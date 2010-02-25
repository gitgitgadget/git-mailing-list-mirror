From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH jh/notes] t3301-notes: insert a shbang line in
 ./fake_editor.sh
Date: Thu, 25 Feb 2010 12:31:42 +0100
Message-ID: <201002251231.43028.johan@herland.net>
References: <4B865376.9030209@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 12:31:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkbwc-0003dR-7Q
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 12:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117Ab0BYLbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 06:31:45 -0500
Received: from smtp.getmail.no ([84.208.15.66]:62246 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759252Ab0BYLbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 06:31:45 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYE008OHAOWHGA0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Feb 2010 12:31:44 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KYE00239AOVNL20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 25 Feb 2010 12:31:44 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.25.111825
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <4B865376.9030209@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141046>

On Thursday 25 February 2010, Johannes Sixt wrote:
> From: Johannes Sixt <j6t@kdbg.org>
> 
> This is required on Windows because git-notes is now a built-in
> rather than a shell script.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
