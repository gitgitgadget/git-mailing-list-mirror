From: David Soria Parra <dsoria@gmx.net>
Subject: Re: [PATCH v2] Improve portability: Cast pid_t's to uintmax_t
Date: Sun, 31 Aug 2008 14:26:30 +0200
Message-ID: <48BA8DF6.9020008@gmx.net>
References: <1220184579-13808-1-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 14:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZm1q-0006oW-SV
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 14:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350AbYHaM0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 08:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbYHaM0d
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 08:26:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:45836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758342AbYHaM0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 08:26:33 -0400
Received: (qmail invoked by alias); 31 Aug 2008 12:26:31 -0000
Received: from p57AEC75A.dip.t-dialin.net (EHLO [192.168.1.116]) [87.174.199.90]
  by mail.gmx.net (mp002) with SMTP; 31 Aug 2008 14:26:31 +0200
X-Authenticated: #235172
X-Provags-ID: V01U2FsdGVkX1/GUJgrguvG5KJw5cK3iQtZb2kQJEe2/AT4oGg6Jw
	tI4uGbXMUi8j7K
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <1220184579-13808-1-git-send-email-sn_@gmx.net>
X-Enigmail-Version: 0.95.6
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94476>


> 
>  Here is a revised version of the portability patch. It's based on next to
>  avoid conflicts due to the style fixups in
>  460c201039471d22194ca871290c098bfe6ce6a3.

not my day. I read the patch and commit message 3 times, but I forgot 
the topic is 'Cast pid_t's to uintmax_t' and not intmax_t.
