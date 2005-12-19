From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: using-topic-branches.txt
Date: Sun, 18 Dec 2005 22:27:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512182225310.4827@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F93AC@hdsmsx401.amr.corp.intel.com>
 <7vfyoplk0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 07:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoEUu-0001ob-3p
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 07:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVLSG11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 01:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbVLSG11
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 01:27:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750734AbVLSG10 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 01:27:26 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBJ6RJDZ030221
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 18 Dec 2005 22:27:19 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBJ6RIK2012903;
	Sun, 18 Dec 2005 22:27:18 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyoplk0r.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13816>



On Sun, 18 Dec 2005, Junio C Hamano wrote:

> "Brown, Len" <len.brown@intel.com> writes:
> 
> > This works for me, but now it requires a password to update
> > when before it did not.
> 
> You are right.  I do not have preference either way myself what
> to put in this document.  However, the change stops recommending
> rsync://, which is something I prefer to keep.

Well, you can use "git://git.kernel.org/" for reading.

Personally, I use master.kernel.org both for reading and writing, but I 
end up using an ssh key with an empty passphrase.

		Linus
