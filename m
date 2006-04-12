From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Some Commit Messages Scare git-rev-list
Date: Wed, 12 Apr 2006 13:04:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604121303520.14565@g5.osdl.org>
References: <1144847462.5213.6.camel@localhost.localdomain>
 <Pine.LNX.4.64.0604121002220.14565@g5.osdl.org> <7v3bgi4op7.fsf@assigned-by-dhcp.cox.net>
 <7vy7ya37o2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Wed Apr 12 22:04:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTlZY-0000ba-3Z
	for gcvg-git@gmane.org; Wed, 12 Apr 2006 22:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWDLUEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Apr 2006 16:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWDLUEN
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Apr 2006 16:04:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34471 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932204AbWDLUEM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Apr 2006 16:04:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3CK45tH001203
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Apr 2006 13:04:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3CK430N017898;
	Wed, 12 Apr 2006 13:04:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7ya37o2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18638>



On Wed, 12 Apr 2006, Junio C Hamano wrote:
>
> [PATCH] stripspace: make sure not to leave an incomplete line.

Ack.

		Linus
