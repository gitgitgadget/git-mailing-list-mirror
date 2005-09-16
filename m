From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] Update cogito.spec.in
Date: Fri, 16 Sep 2005 11:09:06 -0700
Message-ID: <20050916180905.GL8041@shell0.pdx.osdl.net>
References: <20050916064720.GI8041@shell0.pdx.osdl.net> <20050916110605.GC25169@pasky.or.cz> <20050916154631.GJ8041@shell0.pdx.osdl.net> <7vr7bonb25.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 20:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGKeD-0007Lt-1l
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 20:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbVIPSJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 14:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbVIPSJO
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 14:09:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24511 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161220AbVIPSJN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 14:09:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8GI97Bo003493
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Sep 2005 11:09:08 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8GI97jh004283;
	Fri, 16 Sep 2005 11:09:07 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8GI978k004282;
	Fri, 16 Sep 2005 11:09:07 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7bonb25.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8700>

* Junio C Hamano (junkio@cox.net) wrote:
> Chris Wright <chrisw@osdl.org> writes:
> 
> > Primary reason is it now requires git, which has those prereqs.
> 
> Which I fully agree with.
> 
> Could you help me to modernize the git-core.spec.in?  I cannot
> even tell if it needs any fix (I am not an RPM guy), but I
> suspect dropping Vendor: may apply to git-core as well.

Yes, I'm actually working on that ATM.  Update will follow shortly.

thanks,
-chris
