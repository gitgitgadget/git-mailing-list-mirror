From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk highlight feature
Date: Tue, 2 May 2006 17:23:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 02:23:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb593-0002Gi-09
	for gcvg-git@gmane.org; Wed, 03 May 2006 02:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWECAXF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWECAXF
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 20:23:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49627 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751033AbWECAXE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 20:23:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k430N1tH007424
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 2 May 2006 17:23:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k430N0br020124;
	Tue, 2 May 2006 17:23:00 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19449>



On Tue, 2 May 2006, Linus Torvalds wrote:
> 
> Ie not a separate menu, but having the current "view" radio buttons be 
> more flexible. 

The obvious way to do it would be to just have two buttons per view: one 
exclusive one (for the main view - only one selected at a time), and the 
other one for the "highlight" one where you could allow multiple views to 
be selected for highlighting.

		Linus
