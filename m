From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
 other commit links ideas)
Date: Tue, 25 Apr 2006 11:52:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604251151350.3701@g5.osdl.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain>
 <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604250811230.3701@g5.osdl.org> <Pine.LNX.4.64.0604250833540.3701@g5.osdl.org>
 <e2lijt$aco$1@sea.gmane.org> <Pine.LNX.4.64.0604251004410.3701@g5.osdl.org>
 <BAYC1-PASMTP091348C4C33C5A0E83C012AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251106400.3701@g5.osdl.org>
 <BAYC1-PASMTP04D82622D9D5DA7E352079AEBF0@CEZ.ICE> <Pine.LNX.4.64.0604251125010.3701@g5.osdl.org>
 <e2lqf1$a5k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 20:52:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYSdz-0007Wo-Ix
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 20:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDYSwN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 14:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWDYSwM
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 14:52:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22209 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751358AbWDYSwM (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 14:52:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3PIq9tH019086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 25 Apr 2006 11:52:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3PIq8OA001034;
	Tue, 25 Apr 2006 11:52:09 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e2lqf1$a5k$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19167>



On Tue, 25 Apr 2006, Jakub Narebski wrote:
> 
> Additionally, in "related" links we require that object exist (core git),
> regardless of detailed semantics.

And as I've now mentioned a hundred times, that's just unacceptable to me. 
No suggested use of this has actually been useful, that I can tell.

		Linus
