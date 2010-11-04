From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Wed, 3 Nov 2010 22:22:02 -0700
Message-ID: <3014427A-06FC-4EEB-B823-F3716E1DA4E5@sb.org>
References: <1288847836-84882-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 06:22:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDsH4-0008OB-Tf
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 06:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab0KDFWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 01:22:06 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:56136 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470Ab0KDFWE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 01:22:04 -0400
Received: by pxi15 with SMTP id 15so95979pxi.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 22:22:04 -0700 (PDT)
Received: by 10.142.203.20 with SMTP id a20mr180008wfg.293.1288848124569;
        Wed, 03 Nov 2010 22:22:04 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id e14sm14807410wfg.20.2010.11.03.22.22.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 22:22:03 -0700 (PDT)
In-Reply-To: <1288847836-84882-1-git-send-email-kevin@sb.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160692>

On Nov 3, 2010, at 10:17 PM, Kevin Ballard wrote:

> Add a new command "shell", which takes an option commit. It simply exits
> to the shell with the commit (if given) and a message telling the user how
> to resume the rebase. This is effectively the same thing as "x false" but
> much friendlier to the user.

That was supposed to say "optional comment", not "option commit". And again
below, "comment" not "commit".

-Kevin Ballard
