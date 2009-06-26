From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 17:10:27 +0200
Message-ID: <200906261710.27881.jnareb@gmail.com>
References: <200906252122.51737.jnareb@gmail.com> <20090626101605.GB9780@m62s10.vlinux.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 26 17:11:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKD4k-0003Uv-A5
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 17:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZFZPK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 11:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZFZPK2
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 11:10:28 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:57510 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZFZPK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 11:10:27 -0400
Received: by fxm9 with SMTP id 9so2162401fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=efbNwR/tlcHP6Kb1h9lrgKO8PjU54MXD/PDEYepfTQU=;
        b=nj2CVYcPC30kuHAEAY9E5pmDgKaCBqt30aIJmA/zegYRXOgcmETW99BnN6/xErCz+Z
         wB/mxChM4FjRzs1IpWbSXmOs8uUPAx1subCYpbXEfGaZ7eICazlUwU7yIiK+3+uF1QA4
         vTZCqDu38i7aLYXuq6yADfzN+pKRfALTrDu+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qHGk1Kg6Xg+PQETMgIycp7morjbi0crYatFPjF418UHTgkK5uAFNJx1sC+VDIbjzSR
         itAfIiKM0W1qJ09DwDfu6lZUmJHWhP17fC4DqUKlJlROjvWHa8L2G9It0ueLpn/K4ueI
         188jYYJ7gyEeL2zPKDhvEMWjz1QjtN4ByD6Zs=
Received: by 10.103.39.3 with SMTP id r3mr2361052muj.56.1246029029489;
        Fri, 26 Jun 2009 08:10:29 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id e10sm17864796muf.14.2009.06.26.08.10.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 08:10:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090626101605.GB9780@m62s10.vlinux.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122304>

On Fri, 26 June 2009, Peter Baumann wrote:
> On Thu, Jun 25, 2009 at 09:22:50PM +0200, Jakub Narebski wrote:
 
> > The *test* version of this year survey can be now found at
> > the following URL (as in previous year, we use Survs.com)
> > 
> >   http://www.survs.com/survey?id=2PIMZGU0&channel=TFN2Y52K7Y
> > 
> > Please tell me what you think about questions and about selection
> > of possible answers in single choice/multiple choice questions.
> > If you have better idea for theme (mainly background and font 
> > colors, and perhaps font size), help would be appreciated.  Is it
> > better to use vertical form everywhere, or should we use horizontal
> > layout of answers for questions with short number of possible
> > answers?  How long does it take to fill survey?
> 
> Remarks:
> 
> - I find the visual layout of footnotes to 10 ("What do you use to edit contents under
>   version control with Git?  What kind of editor, IDE or RAD you use working
>   with Git?") a little distracting. Could those at least be seperated by a newline?

This is unfortunately technical limitation of Survs.com.  It replaces
run of empty lines with _single_ linebreak in text elements.  I have
submitted request for more rich formatting options (like whitelist HTML)
as feedback, but for the time being (if it didn't get accepted before
"Git User's Survey 2009" is run) I can simply divide those "footnotes"
in more than one text element.

> 
> - I'm not sure if question 16 ("How often do you use the following forms of git
>   commands or extra git tools?") isn't a little too much. At least I got scared by looking
>   at all questions in there and I imagine that people get easily bored answering them.
> 
> - The same might be true for question 17 and 18.

As you probably remember question "16/17. How often do you use the
following forms of git commands or extra git tools?" wasn't present
in first two drafts of Git User's Survey 2009.  It was only added
at request from #git channel.

On one hand side this question allows responders to get to know git
commands and forms of git commands they wouldn't otherwise know about.
So it can be seen as learning tool.  Answers to this question are also
quite interesting from the point of view of analysing git usage(s).

On the other hand side this question is very long; so long that due to
technical limits had to be split in two.  It is time-consuming and 
quite scary.  Also one can get similar statistics from filtered history;
we could also create version of git which would gather such statistics
and at request of user would aggregate responses and format for sending
(or even send via email), similarly to what Linux Counter does.


Possible solution would be to delete this question (again).  
Alternatively this question could be marked explicitly as optional
(even though all questions are optional in this survey), and put
it in separate page with more difficult / time consuming questions.

> 
> 
> Overall, I like the survey.

Thanks!  Thank you very much for taking your time to test this survey,
and to write your comments about it.
-- 
Jakub Narebski
Poland
