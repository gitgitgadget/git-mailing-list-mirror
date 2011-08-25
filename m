From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Final report: Some observations
Date: Thu, 25 Aug 2011 12:26:15 +0530
Message-ID: <CALkWK0=HJJdy-ZHOLVLRm1AOLLbnXsOk=603_iCaGv4h6oLEmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 25 08:56:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwTrl-00086J-JH
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 08:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab1HYG4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 02:56:37 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61162 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059Ab1HYG4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 02:56:36 -0400
Received: by wyg24 with SMTP id 24so1409909wyg.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=GUOs5D8a0B3clC+MzFYgDp7T1WF1icJcOsVTttdsSZY=;
        b=BJxk2ifmWvBWCH5uJMdSVEzE5e1qsn7IDdtnK3wlHjfwMs9UoHDrxgGVjuxHROPTNY
         pGwEmhBjlI/w1o9R96NRRscJUe9CgeT1bKbCBPmtHjAON7k1xEbdR6lJ1XafHQjjkqzj
         3EMXZ/hkgtiRJZRr6YfOBmqXhIIDFnlR4ZJko=
Received: by 10.216.18.130 with SMTP id l2mr255667wel.74.1314255395101; Wed,
 24 Aug 2011 23:56:35 -0700 (PDT)
Received: by 10.216.28.205 with HTTP; Wed, 24 Aug 2011 23:56:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180061>

Hi,

I've been involved with the Git community since January 2010.  Apart
from tiny miscellaneous patches, I spent two summers as a GSoC student
writing more chunky portions.  I'll write down some of my personal
observations here; it's nothing new, but I hope the community can
benefit from learning what a (relatively) new contributor observes.
Classifying them as "positive" or "negative" attributes makes little
sense in my opinion.
1. I really like the Git and the community.  It's a great piece of
software, and the community makes sure that it stays that way.  As a
result, it arguably has a high entry barrier.
2. It's an exponential climb for a contributor.  Looking back, I can
find issues with the first few patches that I contributed, but reviews
weren't as stringent.  It also has to do with the parts of Git I've
tried to contribute to- I slowly went from writing tiny documentation
patches to large features.
3. Excellent timely reviews.  If there's one reason I stayed around
despite all the difficulties, this has to be it.  I don't know any
faster way to improve as a software engineer.
4. Language is beautiful and entertaining! People make use of their
language skills to write interesting reviews and commit messages, not
choppy dry ones.
5. High transparency.  It looks like almost everything is on-list.
6. Largely impersonal.  Although there are exceptions, people
generally don't talk about their personal lives; some people don't use
their real names.

Personally, I feel a little guilty because I feel that I've gained
more than I've given back.  I'll try to make up for this over the
coming months and years.

Thanks.

-- Ram
