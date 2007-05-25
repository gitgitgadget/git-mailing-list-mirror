From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn and SVK mirror between two repositories
Date: Fri, 25 May 2007 13:50:43 -0700
Message-ID: <46574C23.3080500@midwinter.com>
References: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vinubalaji Gopal <vinubalaji@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 22:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrgkO-0004o6-U8
	for gcvg-git@gmane.org; Fri, 25 May 2007 22:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXEYUur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 16:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbXEYUur
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 16:50:47 -0400
Received: from tater.midwinter.com ([216.32.86.90]:60129 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753697AbXEYUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 16:50:46 -0400
Received: (qmail 24901 invoked from network); 25 May 2007 20:50:45 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=oBvIapZ6jCt5lKMV5QbSHx9rR3F+F2TxgHZPIjbmSGOeEgFavHoUL2Wi7NtxBLPW  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 25 May 2007 20:50:45 -0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
In-Reply-To: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48412>

Vinubalaji Gopal wrote:
> Hi all,
>    I have been trying hard to find if it is possible to mirror (or
> clone in git-svn terms) two svn repositories and update changes from
> one to other or do even more complex operations with these two
> repositories. 

I don't know how svk would change things, but I did something similar 
and wrote it up here:

http://thread.gmane.org/gmane.comp.version-control.git/45060

-Steve
