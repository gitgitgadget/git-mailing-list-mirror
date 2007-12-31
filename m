From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation/user-manual.txt: fix typo
Date: Mon, 31 Dec 2007 11:28:07 -0500
Message-ID: <20071231162807.GA3662@fieldses.org>
References: <1198921945-25616-1-git-send-email-hendeby@isy.liu.se> <1199107895-25950-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Mon Dec 31 17:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9NVO-0004BP-E5
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 17:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXLaQ2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbXLaQ2N
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 11:28:13 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38753 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbXLaQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 11:28:12 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J9NUl-00012D-IE; Mon, 31 Dec 2007 11:28:07 -0500
Content-Disposition: inline
In-Reply-To: <1199107895-25950-1-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69405>

On Mon, Dec 31, 2007 at 02:31:35PM +0100, Gustaf Hendeby wrote:
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
> ---
> 
> I didn't see this one in the latest patches added to v1.5.4-rc2 so I
> guess it was forgotten, or just dropped because it seems I forgot to
> sign it the last time.  (Sorry about that, it should teach me not to
> do anything important at 4 in the morning...)  I think the patch is
> obviously correct so I'm resending.

Yep, thanks!  Applied and pushed out to

	git://linux-nfs.org/~bfields/git.git maint

--b.

commit 57283291b55cdc4ab726231073450d185beb361a
Author: Gustaf Hendeby <hendeby@isy.liu.se>
Date:   Mon Dec 31 14:31:35 2007 +0100

    Documentation/user-manual.txt: fix typo
    
    Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>

commit f18b1c55e5b7478524c15685cd643555fc919f3f
Author: J. Bruce Fields <bfields@citi.umich.edu>
Date:   Fri Dec 21 19:57:16 2007 -0500

    Documentation: fix remote.<name>.skipDefaultUpdate description
    
    Fix the subcommand name.
    
    Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
