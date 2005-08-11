From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Making CFLAGS compilant with GNU Coding Standards
Date: Thu, 11 Aug 2005 00:01:33 -0400
Message-ID: <1123732893.18644.41.camel@dv>
References: <1123306575.7588.17.camel@dv.roinet.com>
	 <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 06:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E34GC-0008SQ-7j
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 06:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVHKEBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 00:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVHKEBg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 00:01:36 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:26343 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932235AbVHKEBg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 00:01:36 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E34Dy-0000Wj-3i
	for git@vger.kernel.org; Wed, 10 Aug 2005 23:59:22 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E34G6-0000y4-3p; Thu, 11 Aug 2005 00:01:34 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7B41XPt003721;
	Thu, 11 Aug 2005 00:01:33 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio!

On Mon, 2005-08-08 at 13:53 -0700, Junio C Hamano wrote:
> Seriously, I do not intend to discarded this patch, but I am
> currently not taking Makefile patches unless they fix real
> breakage.

Try "make CFLAGS=-O3"

> I do want to revisit Makefile issues after 0.99.4, along with
> the changes Pasky sent several days ago.  Please remind me about
> them after Wednesday.

It's "after Wednesday" and 0.99.4 is out (many thanks).

-- 
Regards,
Pavel Roskin
