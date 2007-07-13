From: "H. Peter Anvin" <hpa@zytor.com>
Subject: kernel.org needs gitweb help
Date: Fri, 13 Jul 2007 16:12:44 -0700
Message-ID: <469806EC.1050104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935345AbXGMXN3@vger.kernel.org Sat Jul 14 01:13:54 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935345AbXGMXN3@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9UKa-0002Lp-Oo
	for glk-linux-kernel-3@gmane.org; Sat, 14 Jul 2007 01:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935345AbXGMXN3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 Jul 2007 19:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762391AbXGMXMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jul 2007 19:12:49 -0400
Received: from terminus.zytor.com ([198.137.202.10]:57671 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759736AbXGMXMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jul 2007 19:12:47 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.8) with ESMTP id l6DNCj64005829
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 16:12:45 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.8) with ESMTP id l6DNCjmp010441;
	Fri, 13 Jul 2007 16:12:45 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l6DNCjgo017337;
	Fri, 13 Jul 2007 16:12:45 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3663/Fri Jul 13 12:16:34 2007 on terminus.zytor.com
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52421>

Hi all,

A lot of people have asked me if there is anything they can do to help
out kernel.org.  At this point, the number one thing anyone could do to
help, and which would be reasonably self-contained a project, would be
to help maintain our fork of gitweb:

http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary

We really need the caching version of gitweb, but it does have a number
of problems, including the non-working tarball generator.

	-hpa
