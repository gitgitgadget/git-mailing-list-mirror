From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitk: Starting translation for Norwegian
Date: Mon, 8 Dec 2008 08:31:03 -0800
Message-ID: <20081208163103.GF31551@spearce.org>
References: <20081203225411.GA12563@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:32:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9j24-0007EK-Qm
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753239AbYLHQbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbYLHQbG
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:31:06 -0500
Received: from george.spearce.org ([209.20.77.23]:37489 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbYLHQbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:31:05 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 204E738200; Mon,  8 Dec 2008 16:31:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081203225411.GA12563@frsk.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102552>

Fredrik Skolmli <fredrik@frsk.net> wrote:
> 
> This file have been used locally for some time, and is near completion. Will
> put an effort into completing it later on, or just leave it as an excercise for
> other Norwegians.
> 
> Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>
> ---
> 
> If there are any issues with character encoding etc and you'd like it as an
> attachment, please let me know.

Can you resend as an attachment?  The email encoding is listed as
iso-8859-1 but the file content looks to be UTF-8.  msgfmt doesn't
like it after the patch is applied.

In general we have found it is better to send po patches as
attachments.  Its a small bit more work for the reviewer and the
maintainer to apply, but it avoids encoding problems with the
patch file.
 
>  git-gui/po/nb.po | 2484 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 2484 insertions(+), 0 deletions(-)
>  create mode 100644 git-gui/po/nb.po

-- 
Shawn.
