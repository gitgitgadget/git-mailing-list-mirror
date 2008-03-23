From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 12:19:36 -0700
Message-ID: <47E6AD48.7090507@zytor.com>
References: <47E69044.3000207@zytor.com> <alpine.LNX.1.00.0803231509060.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdVjy-0007sb-CK
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbYCWTTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbYCWTTl
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:19:41 -0400
Received: from terminus.zytor.com ([198.137.202.10]:38592 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbYCWTTk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:19:40 -0400
Received: from mail.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m2NJJbjg017840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 23 Mar 2008 12:19:38 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m2NJJb42031906;
	Sun, 23 Mar 2008 12:19:37 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m2NJJaO2008781;
	Sun, 23 Mar 2008 12:19:37 -0700
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <alpine.LNX.1.00.0803231509060.19665@iabervon.org>
X-Virus-Scanned: ClamAV 0.92.1/6005/Tue Feb 26 14:01:21 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77949>

Daniel Barkalow wrote:
> 
> Maybe "git --work-tree=. clone <remote>"? It currently complains about the 
> directory existing, but we could have a flag to override that. And this 
> ends up with a sort of neat arrangement where your home directory is "Not 
> a git repository", but if you go into the subdirectory that has the repo 
> files, you can do all the usual stuff. This helps to avoid the case where 
> you forget to do "git init" in a new project and accidentally check things 
> into your dotfiles.
> 
> 	-Daniel

That sounds cumbersome.

	-hpa
