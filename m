From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 11/13] notes: add shorthand --ref to override
 GIT_NOTES_REF
Date: Thu, 11 Mar 2010 11:56:46 +0100
Message-ID: <201003111156.46614.johan@herland.net>
References: <cover.1268229087.git.trast@student.ethz.ch>
 <dd44a5b7ef528c37293a0aa3df2e5016938d23fa.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 11 11:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npg5Y-0007B8-Q5
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 11:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984Ab0CKK54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 05:57:56 -0500
Received: from smtp.getmail.no ([84.208.15.66]:37890 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756916Ab0CKK5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 05:57:55 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400G4X6ENRU30@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:56:47 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400FLT6ENA940@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:56:47 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.104819
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <dd44a5b7ef528c37293a0aa3df2e5016938d23fa.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141950>

On Wednesday 10 March 2010, Thomas Rast wrote:
> Adds a shorthand option that overrides the GIT_NOTES_REF variable, and
> hence determines the notes tree that will be manipulated.  It also
> DWIMs a refs/notes/ prefix.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Johan Herland <johan@herland.net>

-- 
Johan Herland, <johan@herland.net>
www.herland.net
