From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Query about status of http-pull
Date: Wed, 24 Aug 2005 11:25:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508241125080.3317@g5.osdl.org>
References: <1124899847.7187.18.camel@lycan.lan> <Pine.LNX.4.63.0508241233260.23242@iabervon.org>
 <7v1x4jfbdy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 20:27:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7zwn-0007Cy-3M
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 20:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVHXSZ6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Aug 2005 14:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVHXSZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Aug 2005 14:25:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751352AbVHXSZ5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2005 14:25:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7OIPjjA022368
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 24 Aug 2005 11:25:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7OIPhuN029743;
	Wed, 24 Aug 2005 11:25:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x4jfbdy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7717>



On Wed, 24 Aug 2005, Junio C Hamano wrote:
> 
> Added at the end of git-repack-script (Linus can disable it by
> giving an '-n' flag when packing his private repositories).

No, I just haven't updated my git on master.kernel.org in a while. So 
nothing to disable.

I ran git-update-server-info manually, so it should work now.

		Linus
