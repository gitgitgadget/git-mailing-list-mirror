From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git-walkthrough-add script
Date: Fri, 4 Jan 2008 23:26:41 +0000
Message-ID: <2CC98B8C-CBB1-4C26-8C94-B152A4D02DDC@simplicidade.org>
References: <1199426431-sup-6092@south>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: William Morgan <wmorgan-git@masanjin.net>
X-From: git-owner@vger.kernel.org Sat Jan 05 00:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAvwV-0004zs-On
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 00:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYADX0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 18:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYADX0l
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 18:26:41 -0500
Received: from mail.sl.pt ([212.55.140.13]:46507 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753700AbYADX0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 18:26:41 -0500
Received: (qmail 22199 invoked from network); 4 Jan 2008 23:26:33 -0000
X-Virus-Status: Clean (0.00973 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00007 seconds / 1.78630 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.65]) (melo@[85.240.127.49])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 4 Jan 2008 23:26:33 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.127.49 as permitted sender)
In-Reply-To: <1199426431-sup-6092@south>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69615>

Hi,

On Jan 4, 2008, at 6:14 AM, William Morgan wrote:

> I've written a little script to do darcs-style hunk-by-hunk
> walkthroughs. It's based on the git-hunk-commit script that was  
> floating
> around. Maybe someone else will find it useful.
>
> http://git-wt-commit.rubyforge.org/

Maybe I'm doing something wrong, but comparing git-add -p with your  
script, git-add -p is more darcs'ish. With git-add, if I have several  
changes in the same file, I get to choose per hunk.

You script asks me to add all the changes in the same file at once.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
