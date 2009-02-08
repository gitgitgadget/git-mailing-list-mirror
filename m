From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: [PATCH] Enable setting attach in .gitconfig for git-format-patch.
Date: Sat, 07 Feb 2009 21:24:42 -0600
Message-ID: <498E507A.8080200@codeweavers.com>
References: <498E038F.3090704@codeweavers.com> <alpine.DEB.1.00.0902072344350.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 04:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW0P1-0001Nw-UF
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 04:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752564AbZBHDZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 22:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbZBHDZt
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 22:25:49 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:54514 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbZBHDZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 22:25:48 -0500
Received: from localhost
	([127.0.0.1] helo=[10.0.0.16] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LW0Il-0004LC-Fd; Sat, 07 Feb 2009 21:25:47 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.17 (X11/20081018)
In-Reply-To: <alpine.DEB.1.00.0902072344350.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108916>

> Pity.  You attached the patch.  So I do not quote the part where you use a 
> strlen() > 0 which would better be a *value.  But it would be nice to fix 
> the issue.

That's a good point; I'll resend. Thanks for the review.

Cheers,

Jeremy
