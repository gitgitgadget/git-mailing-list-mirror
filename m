From: Peter Baumann <waste.manager@gmx.de>
Subject: [OT] How to get the discussion details via notes
Date: Wed, 31 Oct 2012 10:53:27 +0100
Message-ID: <20121031095327.GB18557@m62s10.vlinux.de>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
 <20121031003721.GV15167@elie.Belkin>
 <CAGdFq_jNM_48muXJ0BX2ehC=k8T9GLui_QtRO8D8C7h6b5jyHg@mail.gmail.com>
 <20121031060529.GA30432@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:53:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTUzY-0001ZC-An
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 10:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2JaJxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 05:53:32 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:52163 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751687Ab2JaJxb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 05:53:31 -0400
Received: (qmail invoked by alias); 31 Oct 2012 09:53:29 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp016) with SMTP; 31 Oct 2012 10:53:29 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+0TsorjM60Pqh2Q+x3mZQakHiI+ABdHY0ueWlzs6
	u6hpV7yVcmx1NO
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 49925EC002; Wed, 31 Oct 2012 10:53:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121031060529.GA30432@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208803>

Dropping the Cc list, as this is off topic

On Tue, Oct 30, 2012 at 11:05:29PM -0700, Jonathan Nieder wrote:
> Sverre Rabbelier wrote:
> 
> > Thanks for the thorough explanation. Perhaps some of that could make
> > it's way into the commit message?
> 
> It's fine with me if it doesn't, since the original commit message
> covers the basics (current behavior and intent of the change) in its
> first two paragraphs and anyone wanting more detail can use
> 
> 	GIT_NOTES_REF=refs/remotes/charon/notes/full \
> 	git show --show-notes <commit>
> 
> to find more details.

I seem to miss something here, but I don't get it how the notes ref
becomes magically filled with the details of this discussion.

Care to explain?

-Peter
