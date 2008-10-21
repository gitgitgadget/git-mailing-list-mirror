From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/7] gitk: Allow forcing branch creation if it already exists.
Date: Tue, 21 Oct 2008 22:38:25 +1100
Message-ID: <18685.48945.637464.604058@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-3-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:43:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFds-0003wK-FC
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbYJULmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYJULmF
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:42:05 -0400
Received: from ozlabs.org ([203.10.76.45]:33931 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753797AbYJULmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:42:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 57008DDDE1; Tue, 21 Oct 2008 22:41:59 +1100 (EST)
In-Reply-To: <1223449540-20457-3-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98779>

Alexander Gavrilov writes:

> If gitk knows that the branch the user tries to create exists,
> it should ask whether it should overwrite it. This way the user
> can either decide to choose a new name, or move the head while
> preserving the reflog.

Applied, thanks.

Paul.
