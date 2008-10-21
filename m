From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/7] gitk: Fix file list context menu for merge commits.
Date: Tue, 21 Oct 2008 22:39:55 +1100
Message-ID: <18685.49035.922737.347026@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-5-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:43:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFdt-0003wK-7s
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbYJULmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 07:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753797AbYJULmG
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:42:06 -0400
Received: from ozlabs.org ([203.10.76.45]:33933 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800AbYJULmB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:42:01 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5F0A2DDDEA; Tue, 21 Oct 2008 22:41:59 +1100 (EST)
In-Reply-To: <1223449540-20457-5-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98778>

Alexander Gavrilov writes:

> Currently it displays an ugly error box, because the
> treediffs array is not filled for such commits. This
> is clearly unacceptable.

Applied, thanks, with a better patch description, one that actually
described the remedial action. :)

Paul.
