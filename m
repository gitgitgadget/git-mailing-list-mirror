From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Help with a tcl/tk gui thing..
Date: Wed, 1 Oct 2008 16:06:36 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810011605001.3341@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0810011240390.3575@nehalem.linux-foundation.org> <237967ef0810011403i2b18255and988df29a71798bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 01:07:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlAnQ-0001lM-2s
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 01:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYJAXGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 19:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbYJAXGk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 19:06:40 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47485 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751622AbYJAXGk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2008 19:06:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m91N6bjc003146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Oct 2008 16:06:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m91N6al0009078;
	Wed, 1 Oct 2008 16:06:36 -0700
In-Reply-To: <237967ef0810011403i2b18255and988df29a71798bf@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97278>



On Wed, 1 Oct 2008, Mikael Magnusson wrote:
> 
> git clone git://mika.l3ib.org/tracker.git
> 
> I wrote it in pygtk since I know zero to no tcl/tk, hope that's okay.
> It has a label with the time remaining (simply read from the daemon file),
> and shows the text in red if less than 10% is remaining. You'll need to
> change the ./ in cb_function to /var/log/tracker since I forgot to change
> that and I'm lazy :).

Well, it doesn't do anything at all for me except change the cursor to a 
cross, and if I'm a n00b with tcl/tk, I'm even more of one with pygtk.

I merged the two other suggestions, though. And am open to seeing that 
pygtk thing too as an alternative, but only if it actually works for me ;)

		Linus
