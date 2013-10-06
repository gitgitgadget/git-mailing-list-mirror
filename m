From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCHv2 1/3] Documentation/git-svn: Promote the use of --prefix in docs + examples
Date: Sun, 6 Oct 2013 10:51:03 +0100
Organization: OPDS
Message-ID: <1B588C9FE7614A6080C98FD340530DA5@PhilipOakley>
References: <20131003190139.GA8710@dcvr.yhbt.net> <1381015833-696-1-git-send-email-johan@herland.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <tfnico@gmail.com>, "Eric Wong" <normalperson@yhbt.net>
To: "Johan Herland" <johan@herland.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 06 11:51:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VSkzo-0002n6-8v
	for gcvg-git-2@plane.gmane.org; Sun, 06 Oct 2013 11:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab3JFJvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Oct 2013 05:51:04 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:37315 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582Ab3JFJvC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Oct 2013 05:51:02 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlkGANgxUVJOl3GZ/2dsb2JhbABZgweJcLgoCoESF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBxcGARIIAgECAwGHbwq7I49RgyaBBAOJAYYTmm2BZoE/Ow
X-IPAS-Result: AlkGANgxUVJOl3GZ/2dsb2JhbABZgweJcLgoCoESF3SCIAUBAQQBCAEBLh4BASEFBgIDBQIBAxUMJRQBBBoGBxcGARIIAgECAwGHbwq7I49RgyaBBAOJAYYTmm2BZoE/Ow
X-IronPort-AV: E=Sophos;i="4.90,1043,1371078000"; 
   d="scan'208";a="443190247"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip02ir2.opaltelecom.net with SMTP; 06 Oct 2013 10:50:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235737>

From: "Johan Herland" <johan@herland.net>
> Currently, the git-svn defaults to using an empty prefix, which ends
> up placing the SVN-tracking refs directly in refs/remotes/*. This
> placement runs counter to Git's convention of placing remote-tracking
> branches in refs/remotes/$remote/*.
<snip>
>
> This is also in preparation for changing the default value of --prefix
> at some point in the future.
>
> Cc: Eric Wong <normalperson@yhbt.net>

Excuse my ignorance, but what is the "Carbon copy:" line meant to 
signify?
Should it be a double "Signed-of-by:" or one of the other "-by:" lines?

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
> Documentation/git-svn.txt | 35 +++++++++++++++++++++++++----------
> 1 file changed, 25 insertions(+), 10 deletions(-)
<snip>

Philip Oakley 
