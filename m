From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] tutorial: expanded discussion of commit history
Date: Mon, 22 May 2006 10:23:46 +0200
Organization: At home
Message-ID: <e4rsef$v34$1@sea.gmane.org>
References: <1148255528.61d5d241.0@fieldses.org> <1148255528.61d5d241.1@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon May 22 10:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi5i0-0003kK-Po
	for gcvg-git@gmane.org; Mon, 22 May 2006 10:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEVIYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 04:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWEVIYE
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 04:24:04 -0400
Received: from main.gmane.org ([80.91.229.2]:12437 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750700AbWEVIYA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 04:24:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fi5hh-0003hA-Bq
	for git@vger.kernel.org; Mon, 22 May 2006 10:23:53 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 10:23:53 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 May 2006 10:23:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20488>

J. Bruce Fields wrote:

> +Finally, most commands that take filenames will optionally allow you
> +to precede any filename by a commit, to specify a particular version
> +fo the file:
> +
> +-------------------------------------
> +$ git diff v2.5:Makefile HEAD:Makefile.in
> +-------------------------------------

Why not mention also :<stage>:<filename>, or would <stage> be not defined in
this place of tutorial?

-- 
Jakub Narebski
Warsaw, Poland
