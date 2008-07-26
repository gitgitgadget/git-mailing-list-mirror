From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mailing lists, was Re: [RFC] Git User's Survey 2008
Date: Sat, 26 Jul 2008 09:47:42 -0700 (PDT)
Message-ID: <m38wvovbh2.fsf@localhost.localdomain>
References: <200807230325.04184.jnareb@gmail.com>
	<20080725172313.GE21117@spearce.org>
	<7vr69hsss1.fsf@gitster.siamese.dyndns.org>
	<200807252352.09751.jnareb@gmail.com>
	<20080725215707.GC23202@spearce.org>
	<20080726155138.GB20695@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 18:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMmwo-0001Az-5C
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 18:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbYGZQrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYGZQrp
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 12:47:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:14161 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbYGZQro (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 12:47:44 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1366256nfc.21
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 09:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=AoXNMfGd3oKgroD3uctxD230b+BvWWmREcnxPXAfDU0=;
        b=m7L4hjOFapqRfGi9wwSlp1IRozjMNHzdj0lRjjPU99eXRq7MR3ImDRCHE1HZQT7PfT
         kyHe7U21/bp7ktZn7ffCJp5q0Hspa1of8HL4kPHoMC/9Zt0sL9CocwrZaDGq2y4fpUY2
         EqHZTAOzF1SB1cLW8pUPDmMdCgxuK0eMirLrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=TAF+RQtXV0QxabvFQktk4wL9uDsnlKsyf9BSIhaV1gsc56niUaXkalVdLB0quPXOxZ
         GtqKk6KquUY/2MBl6LhhlgsBVL5FLzyJpLGaQI/EpzEp7pIZmpguC2uWV83PSLUX3TZv
         VKYoegkdWCWWh2YQagoTMh9zfnMfzB3VwanNQ=
Received: by 10.210.86.10 with SMTP id j10mr3564399ebb.31.1217090863080;
        Sat, 26 Jul 2008 09:47:43 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.191])
        by mx.google.com with ESMTPS id 2sm50374821nfv.5.2008.07.26.09.47.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 09:47:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6QGletj021036;
	Sat, 26 Jul 2008 18:47:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6QGlbnJ021032;
	Sat, 26 Jul 2008 18:47:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080726155138.GB20695@jabba.hq.digizenstudio.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90256>

Jing Xue <jingxue@digizenstudio.com> writes:

> On Fri, Jul 25, 2008 at 04:57:07PM -0500, Shawn O. Pearce wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > >
> > > What question about egit/jgit would you like to have in the survey?
> > 
> > I'm not certain what else I would want to ask that is egit/jgit
> > specific.
> 
> Just a thought - how about a question polling whether people would be
> interested in build tool wrappers around jgit - ant tasks, maven
> plugins, etc.?

True, there are a lot of tools written in Java, which have or could
have support for Git: Ant tasks, Maven plugins, Hudson rules
(continuous integration), JIRA (bug/issue tracker).  Some of them
perhaps could use jgit, although if I understand correctly jgit is not
yet full implementation of Git: it is enough for egit, for local clone
of repository.

I don't have any idea how to formulate such question.  I think however
that "hijacking" Git User's Survey to ask a bunch of jgit/egit
questions would be a good idea.  (By the way I have though about
asking for feature requests for gitweb...)

I wonder if similar tools like mentioned above, but for the Ruby camp,
like Capistrano, Merb, Gitosis, whatever use git directly, or do they
use Ruby interface (and which interface).  I don't think there is
implementation of Git in Ruby... hmmmm....

-- 
Jakub Narebski
Poland
ShadeHawk on #git
