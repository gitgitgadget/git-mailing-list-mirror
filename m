From: Andreas Ericsson <ae@op5.se>
Subject: Re: state of libgit2?
Date: Wed, 03 Jun 2009 11:56:19 +0200
Message-ID: <4A2648C3.4000205@op5.se>
References: <200906030822.15516.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: thomas@koch.ro
X-From: git-owner@vger.kernel.org Wed Jun 03 11:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBnCs-0003R8-NI
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 11:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbZFCJ4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 05:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752881AbZFCJ4H
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 05:56:07 -0400
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:57627 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753280AbZFCJ4G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2009 05:56:06 -0400
Received: from source ([209.85.220.212]) by na3sys009aob114.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSiZIt/gUuwnll1w3QtC6LZUk7k/gEkE7@postini.com; Wed, 03 Jun 2009 02:56:09 PDT
Received: by fxm8 with SMTP id 8so10563890fxm.18
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 02:56:06 -0700 (PDT)
Received: by 10.103.12.19 with SMTP id p19mr451614mui.66.1244022966245;
        Wed, 03 Jun 2009 02:56:06 -0700 (PDT)
Received: from clix.int.op5.se (c-8537e055.366-1-64736c20.cust.bredbandsbolaget.se [85.224.55.133])
        by mx.google.com with ESMTPS id 14sm21832746muo.3.2009.06.03.02.56.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 02:56:05 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200906030822.15516.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120594>

Thomas Koch wrote:
> Just want to show, that there is interest in the state and roadmap for 
> libgit2. If I understand right, libgit2 is necessary to get GIT bindings in 
> scripting languages like PHP, Python, etc.
> Please keep on!
> 

Long story short: Shawn shared push access with me. I take patches and work
on them mondays and thursdays, but try to comment on them as soon as I see
them. Ramsay Jones is more or less the only one sending patches right now,
and I still have to respond to his latest series.

Long story long:
Development is slow indeed. Recently Shawn decided to share push access to
repo.or.cz with me, but I went partying, fell down some stairs and hit my
head quite badly not long after so I've been convalescent. Now I'm at a
two day conference event for a different opensource project (Nagios) where
I'm working quite a lot.

Normally, I have two days per week (monday and thursday) to work on open-
source things. That time is split between Nagios and libgit2.

Ramsay Jones is the most active contributor at the time, but he was not
comfortable with push access so I shouldered that responsibility for the
time being.

I'm working (but slowly; see above) on index manipulation. Unfortunately,
that also entails adding about a billion other things, so even if I'd
been 100% healthy things would have been slow.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
