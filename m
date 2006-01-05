From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-ls-files -o no recurse?
Date: Thu, 5 Jan 2006 09:31:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601050926440.3169@g5.osdl.org>
References: <1136400692.5919.11.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0601041330550.3668@g5.osdl.org> <1136481352.5597.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 05 18:32:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYy7-0008F8-IV
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 18:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbWAERcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 12:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWAERcD
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 12:32:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751859AbWAERcB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 12:32:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k05HVwDZ022020
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Jan 2006 09:31:58 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k05HVvNV006846;
	Thu, 5 Jan 2006 09:31:57 -0800
To: Darrin Thompson <darrint@progeny.com>
In-Reply-To: <1136481352.5597.2.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14209>



On Thu, 5 Jan 2006, Darrin Thompson wrote:
> 
> Worked great!

Ok. You can bug Junio about it when he returns, maybe he thinks it's a 
great feature.

> > +static int show_ignored_directories = 0;
> 
> Did you perhaps mean s/ignored/other/g ? I thought maybe you were being
> clever but I couldn't get it to do anything useful with -i, only -o.

Yeah. 

		Linus
