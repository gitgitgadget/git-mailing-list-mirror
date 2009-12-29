From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] MinGW: Use pid_t more consequently, introduce uid_t
 for   greater compatibility
Date: Tue, 29 Dec 2009 22:09:20 +0100
Message-ID: <4B3A7000.4050308@kdbg.org>
References: <hhbldr$di8$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 22:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjK6-0002c3-0X
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbZL2VJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZL2VJ3
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:09:29 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:24286 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752000AbZL2VJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:09:28 -0500
Received: from [77.119.218.203] (77.119.218.203.wireless.dyn.drei.com [77.119.218.203])
	by bsmtp.bon.at (Postfix) with ESMTP id EF141CDF82;
	Tue, 29 Dec 2009 22:09:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <hhbldr$di8$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135822>

Sebastian Schuberth schrieb:
> MinGW: Use pid_t more consequently, introduce uid_t for greater compatibility

Why this? Compatibility with what? What's the problem with the status quo?

-- Hannes
