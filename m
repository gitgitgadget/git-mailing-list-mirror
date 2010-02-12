From: Pavel Roskin <proski@gnu.org>
Subject: Re: [StGit PATCH] mail: Ask for the SMTP credentials before
 sending the messages
Date: Fri, 12 Feb 2010 17:42:58 -0500
Message-ID: <1266014578.25535.9.camel@mj>
References: <20100212161150.12036.62592.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Karl Wiberg <kha@treskal.com>,
	Alex Chiang <achiang@hp.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 23:45:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng4GR-0007z6-Tp
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757930Ab0BLWnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:43:16 -0500
Received: from c60.cesmail.net ([216.154.195.49]:2160 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757912Ab0BLWnO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:43:14 -0500
Received: from unknown (HELO smtprelay1.cesmail.net) ([192.168.1.111])
  by c60.cesmail.net with ESMTP; 12 Feb 2010 17:43:12 -0500
Received: from [192.168.0.22] (unknown [72.92.88.10])
	by smtprelay1.cesmail.net (Postfix) with ESMTPSA id 156E234C69;
	Fri, 12 Feb 2010 17:43:06 -0500 (EST)
In-Reply-To: <20100212161150.12036.62592.stgit@pc1117.cambridge.arm.com>
X-Mailer: Evolution 2.26.3 (2.26.3-1.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139760>

On Fri, 2010-02-12 at 16:11 +0000, Catalin Marinas wrote:
> The original implementation was asking for the SMTP password on every
> patch sent. This patch only asks the password once before sending or
> even editing the cover message and patches.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
> Cc: Pavel Roskin <proski@gnu.org>
> Cc: Alex Chiang <achiang@hp.com>

Tested-by: Pavel Roskin <proski@gnu.org>

-- 
Regards,
Pavel Roskin
