From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: What does this error message mean?
Date: Wed, 22 Feb 2006 04:42:50 +0000
Message-ID: <200602220442.50935.alan@chandlerfamily.org.uk>
References: <200602212206.36685.alan@chandlerfamily.org.uk> <20060222004637.1a066569.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Feb 22 05:43:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBlq8-0006mu-5i
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 05:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWBVEmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 23:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWBVEmu
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 23:42:50 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:17365
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1750744AbWBVEmu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 23:42:50 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1FBlpx-0000aj-DX
	for git@vger.kernel.org; Wed, 22 Feb 2006 04:42:49 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <20060222004637.1a066569.tihirvon@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16590>

On Tuesday 21 February 2006 22:46, Timo Hirvonen wrote:
> On Tue, 21 Feb 2006 22:06:36 +0000
>
> Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> > alan@kanger usermgr[master]$ git commit -a
> > fatal: empty ident  <alan@chandlerfamily.org.uk> not allowed
> >
> > Suddenly started happening, possibly after upgrade (via debian) to git
> > 1.2.1
>
> Your GIT_AUTHOR_NAME is empty?

Yes - seems it was.

Although it has been like that for some months, whereas this is the first time 
git-commit failed.
-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
