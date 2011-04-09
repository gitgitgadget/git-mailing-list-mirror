From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Sat, 9 Apr 2011 22:47:29 +0000
Message-ID: <20110409224729.GA11062@dcvr.yhbt.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu> <1302274674-4231-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Sun Apr 10 00:47:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gwI-00045v-SD
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab1DIWra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 18:47:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57768 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754723Ab1DIWr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:47:29 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3106E1F4F1;
	Sat,  9 Apr 2011 22:47:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1302274674-4231-1-git-send-email-asedeno@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171211>

"Alejandro R. Sede=C3=B1o" <asedeno@mit.edu> wrote:
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Reviewed-by: James Y Knight <jknight@itasoftware.com>

Thanks all, I've acked and pushed out to git://bogomips.org/git-svn.git

If it's not too much trouble, I'd strongly prefer to have a test case
for this so future work doesn't break it.  Thanks.

--=20
Eric Wong
