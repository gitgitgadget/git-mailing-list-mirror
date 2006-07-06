From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC] GIT user survey
Date: Thu, 06 Jul 2006 01:09:38 -0400
Message-ID: <1152162578.10415.59.camel@dv>
References: <4d8e3fd30606240918m6b452314m6514b5e5fc86f147@mail.gmail.com>
	 <e8e1ea$s5c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 07:09:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyM7W-0005Bg-6o
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 07:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWGFFJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 01:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965174AbWGFFJm
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 01:09:42 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:27031 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965169AbWGFFJl
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 01:09:41 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FyM7Q-0007Pt-ET
	for git@vger.kernel.org; Thu, 06 Jul 2006 01:09:40 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FyM7O-00085x-Cd; Thu, 06 Jul 2006 01:09:38 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e8e1ea$s5c$1@sea.gmane.org>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23372>

On Tue, 2006-07-04 at 17:28 +0200, Jakub Narebski wrote:
> Paolo Ciarrocchi wrote:
> 
> > I was wondering whether it could be a good idea to have a kind of "GIT
> > users survey" when google pointed my eyes to this page:
> > http://www.selenic.com/pipermail/mercurial/2006-April/007513.html
> > 
> > So I modified the content of the survey and published a DRAFT here:
> > http://paolo.ciarrocchi.googlepages.com/GITSurvey
> 
> Could you please add the final version (and of course results) on
> Git Wiki (http://git.or.cz/gitwiki), like original one is on Mercurial
> wiki: http://www.selenic.com/mercurial/wiki/index.cgi/UserSurvey ?
> 
> Thanks in advance
> 
> P.S. I wonder why my Mozilla 1.7.12 sees GITSurvey as binary/octet-stream
> instead of text/plain file...

It's not a Mozilla thing.  It's a server configuration.

$ wget http://paolo.ciarrocchi.googlepages.com/GITSurvey
--00:52:45--  http://paolo.ciarrocchi.googlepages.com/GITSurvey
           => `GITSurvey'
Resolving paolo.ciarrocchi.googlepages.com... 64.233.179.93,
64.233.179.91
Connecting to paolo.ciarrocchi.googlepages.com|64.233.179.93|:80...
connected.
HTTP request sent, awaiting response... 200 OK
Length: 2,078 (2.0K) [application/octet-stream]


Regarding the questions (sorry, I could have missed comments of others):

  What is your preferred language?

Preferred to type or preferred to speak?  There answer is not always the
same, at least for me.

  How did you hear about GIT?

With my own ears.  "How did you learn about GIT" would be better because
many respondents probably _read_ about GIT first.

s/histoty/history
s/porcellains/porcelains/

What is the "history depth"?  How do I measure it?

  Which porcelains do you use?

Which child did you abuse today?  Let's avoid loaded questions.  Some
people are just fine with bare git.

Have you tried to get GIT help from other people?

  Better: Have you asked other people to help you with GIT? 

-- 
Regards,
Pavel Roskin
