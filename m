From: Andrew Morton <akpm@osdl.org>
Subject: Re: git-bisect failure
Date: Sat, 10 Sep 2005 02:26:38 -0700
Message-ID: <20050910022638.20832803.akpm@osdl.org>
References: <20050909011034.12f2bf64.akpm@osdl.org>
	<7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 11:27:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EE1dw-0001ZP-Bq
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 11:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVIJJ1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 05:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbVIJJ1T
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 05:27:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42709 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750718AbVIJJ1T (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2005 05:27:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8A9R3Bo025635
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Sep 2005 02:27:06 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j8A9R3N0009101;
	Sat, 10 Sep 2005 02:27:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virx9ir3a.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8253>

Junio C Hamano <junkio@cox.net> wrote:
>
> So it _might_
>  be possible that you said "current LDT" was bad when it was
>  actually good.  That is one possible explanation.

I agree.  Mea culpa.  Sorry.
