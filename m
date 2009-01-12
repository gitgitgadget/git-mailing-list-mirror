From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 03:25:34 -0800 (PST)
Message-ID: <alpine.DEB.2.00.0901120324490.18989@vellum.laroia.net>
References: <200901120246.28364.jnareb@gmail.com> <81b0412b0901120117mf010317m79874a235e29a439@mail.gmail.com> <200901121213.45858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 12:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMKwu-0007WT-Pn
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 12:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414AbZALLZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 06:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbZALLZm
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 06:25:42 -0500
Received: from rose.makesad.us ([219.105.37.19]:60665 "EHLO rose.makesad.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbZALLZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 06:25:41 -0500
Received: from vellum.laroia.net (localhost [127.0.0.1])
	by rose.makesad.us (Postfix) with ESMTP id E3306A010F;
	Mon, 12 Jan 2009 06:25:39 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by vellum.laroia.net (Postfix) with ESMTPS id B50EB3A62BD;
	Mon, 12 Jan 2009 03:25:34 -0800 (PST)
X-X-Sender: paulproteus@vellum.laroia.net
In-Reply-To: <200901121213.45858.jnareb@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105328>

On Mon, 12 Jan 2009, Jakub Narebski wrote:

> But I have to run
>
> $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com
>
> first. Is there any way to automate this?

Check out 'gstm' or 'autossh'.

-- Asheesh.

-- 
You will get what you deserve.
