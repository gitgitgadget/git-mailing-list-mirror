From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 11:43:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511101142370.4627@g5.osdl.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
 <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511101128510.4627@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751211AbVKJTnh@vger.kernel.org Thu Nov 10 20:46:03 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751211AbVKJTnh@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaILA-0002IK-Na
	for glk-linux-kernel-3@gmane.org; Thu, 10 Nov 2005 20:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVKJTnh (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 10 Nov 2005 14:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKJTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:43:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbVKJTng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:43:36 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAAJhQnO025067
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 10 Nov 2005 11:43:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAAJhOXU002153;
	Thu, 10 Nov 2005 11:43:25 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511101128510.4627@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11513>



On Thu, 10 Nov 2005, Linus Torvalds wrote:
>
> But the point is, that if you actually run fsck every time you want to 
> visualize your pending commits, you're going to feel the pain. 
                 ^^^^^^^

That should be "dangling", of course. 

		Linus
