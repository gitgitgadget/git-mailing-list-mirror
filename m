From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Mon, 14 Jan 2008 21:29:32 +0100
Message-ID: <20080114202932.GA25130@steel.home>
References: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Umbers <paul.umbers@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 21:30:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEVwa-00083s-AC
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 21:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYANU3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbYANU3g
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 15:29:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:31563 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbYANU3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 15:29:35 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOV/Ag==
Received: from tigra.home (Faf3b.f.strato-dslnet.de [195.4.175.59])
	by post.webmailer.de (fruni mo24) (RZmta 15.4)
	with ESMTP id v03fd0k0EIkclp ; Mon, 14 Jan 2008 21:29:33 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9C7E1277AE;
	Mon, 14 Jan 2008 21:29:33 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 145D056D22; Mon, 14 Jan 2008 21:29:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70474>

Paul Umbers, Mon, Jan 14, 2008 18:21:44 +0100:
> Trying to create a repository under the cygwin install of git, windows
> XP Pro. I can create the initial repository OK using "git init" and
> add files using "git add .", but when I come to commit I get the
> messages:
> 
> error: invalid object d9b06fceac52f6c24357e6a7f85c601
> 088381152
> fatal: git-write-tree: error building trees

Is it a "text-mode" mount where your repository is to reside?
