From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 4/4] remote: new show output style
Date: Thu, 19 Feb 2009 20:29:13 +0100
Message-ID: <499DB309.7000706@kdbg.org>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com> <1235020471-59982-2-git-send-email-jaysoffian@gmail.com> <1235020471-59982-3-git-send-email-jaysoffian@gmail.com> <1235020471-59982-4-git-send-email-jaysoffian@gmail.com> <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 20:31:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaEbk-0002Nx-IW
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbZBST3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752898AbZBST3X
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:29:23 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:65176 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbZBST3W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:29:22 -0500
Received: from [77.118.143.182] (77.118.143.182.wireless.dyn.drei.com [77.118.143.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 35B72CDF8A;
	Thu, 19 Feb 2009 20:29:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1235020471-59982-5-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110735>

Jay Soffian schrieb:
>  * remote two
>    URL: ../two
> -  HEAD branches:
> -    another
> -    master
> +  HEAD branches: another, master

Any reason why this list of branches is now horizontal instead of 
vertical? I must admit that I don't know what is meant by "HEAD 
branches". Can this list grow large?

I'm asking because I changed horizontal branch lists of 'remote show' 
output to vertical lists some time ago because I found that vertical 
lists are much easier to read if they grow large.

-- Hannes
