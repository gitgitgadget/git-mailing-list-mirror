From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: Add uninstall target to Makefile
Date: Fri, 16 Sep 2005 13:54:03 -0400
Message-ID: <20050916175402.GC22825@tuxdriver.com>
References: <20050916125814.GA8084@igloo.ds.co.ug> <7vfys5ndor.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 19:58:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKTM-0004NH-AK
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 19:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbVIPR57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 13:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbVIPR57
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 13:57:59 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:27909 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161215AbVIPR56 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 13:57:58 -0400
Received: from bilbo.tuxdriver.com (azure.tuxdriver.com [24.172.12.5])
	by ra.tuxdriver.com (8.13.3/8.13.3) with ESMTP id j8GHs7Rs023329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 16 Sep 2005 13:54:07 -0400
Received: from bilbo.tuxdriver.com (localhost.localdomain [127.0.0.1])
	by bilbo.tuxdriver.com (8.13.1/8.13.1) with ESMTP id j8GHs6IP004462;
	Fri, 16 Sep 2005 13:54:06 -0400
Received: (from linville@localhost)
	by bilbo.tuxdriver.com (8.13.1/8.13.1/Submit) id j8GHs434004461;
	Fri, 16 Sep 2005 13:54:04 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Martin Atukunda <matlads@dsmagic.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vfys5ndor.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4-gr0
X-Spam-Checker-Version: SpamAssassin 3.0.4-gr0 (2005-06-05) on 
	ra.tuxdriver.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8697>

On Fri, Sep 16, 2005 at 10:08:04AM -0700, Junio C Hamano wrote:
> Martin Atukunda <matlads@dsmagic.com> writes:
> 
> > Add the uninstall target to the Makefile.
> 
> Sorry, I absolutely detest other peoples' Makefiles that has
> this target.  Why would anybody want this?

Is this a serious question?  To uninstall the binaries e.g. if you
installed them in the wrong place?
-- 
John W. Linville
linville@tuxdriver.com
