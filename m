From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 15:13:29 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
References: <491DE6CC.6060201@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 15 00:15:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L17sc-0001F5-8L
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 00:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYKNXNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 18:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYKNXNz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 18:13:55 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37454 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751536AbYKNXNy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 18:13:54 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAENDTWM030650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Nov 2008 15:13:30 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAENDTTN015774;
	Fri, 14 Nov 2008 15:13:29 -0800
In-Reply-To: <491DE6CC.6060201@op5.se>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.431 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101027>



On Fri, 14 Nov 2008, Andreas Ericsson wrote:
> 
> The license decided for libgit2 is "GPL with gcc exception".

What's the exact language? 

I'm likely ok with GPLv2 + libgcc-like exception, but I'd like to see the 
exact one. I haven't followed the discussions much..

		Linus
