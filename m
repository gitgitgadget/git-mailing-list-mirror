From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: add a string to translation
Date: Mon, 25 May 2009 09:49:30 +1000
Message-ID: <18969.56586.371988.295769@cargo.ozlabs.ibm.com>
References: <200905231148.25678.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon May 25 01:50:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8NSZ-000646-4l
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 01:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbZEXXuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 19:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753619AbZEXXuV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 19:50:21 -0400
Received: from bilbo.ozlabs.org ([203.10.76.25]:43962 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753542AbZEXXuV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 May 2009 19:50:21 -0400
Received: by bilbo.ozlabs.org (Postfix, from userid 1003)
	id 3CD95B6F34; Mon, 25 May 2009 09:50:22 +1000 (EST)
In-Reply-To: <200905231148.25678.barra_cuda@katamail.com>
X-Mailer: VM 8.0.12 under 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119878>

Michele Ballabio writes:

> -    wm title $top [concat $title "-- criteria for selecting revisions"]
> +    wm title $top [concat $title [mc "-- criteria for selecting revisions"]]

Thanks, applied.

Paul.
