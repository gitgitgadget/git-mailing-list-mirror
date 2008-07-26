From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 12:51:21 -0500
Message-ID: <20080726175121.GA15015@spearce.org>
References: <200807230325.04184.jnareb@gmail.com> <20080725172313.GE21117@spearce.org> <7vr69hsss1.fsf@gitster.siamese.dyndns.org> <200807252352.09751.jnareb@gmail.com> <20080725215707.GC23202@spearce.org> <20080726155138.GB20695@jabba.hq.digizenstudio.com> <m38wvovbh2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jing Xue <jingxue@digizenstudio.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 19:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMnwN-0003jf-4g
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbYGZRvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 13:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYGZRvX
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 13:51:23 -0400
Received: from george.spearce.org ([209.20.77.23]:36436 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbYGZRvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 13:51:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C70E8383A5; Sat, 26 Jul 2008 17:51:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m38wvovbh2.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90266>

Jakub Narebski <jnareb@gmail.com> wrote:
> Jing Xue <jingxue@digizenstudio.com> writes:
> > 
> > Just a thought - how about a question polling whether people would be
> > interested in build tool wrappers around jgit - ant tasks, maven
> > plugins, etc.?
> 
> True, there are a lot of tools written in Java, which have or could
> have support for Git: Ant tasks, Maven plugins, Hudson rules
> (continuous integration), JIRA (bug/issue tracker).  Some of them
> perhaps could use jgit, although if I understand correctly jgit is not
> yet full implementation of Git: it is enough for egit, for local clone
> of repository.

  What Java based build tools would you like to see Git support in?
  (choose zero or more, multiple choice)
  Ant, Maven, Hudson, JIRA, other
 
> I wonder if similar tools like mentioned above, but for the Ruby camp,
> like Capistrano, Merb, Gitosis, whatever use git directly, or do they
> use Ruby interface (and which interface).  I don't think there is
> implementation of Git in Ruby... hmmmm....

There is an implementation in Ruby, but I'm not sure what its
state is.

-- 
Shawn.
