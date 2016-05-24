From: David Turner <dturner@twopensource.com>
Subject: Signing off, for now
Date: Tue, 24 May 2016 15:22:30 -0400
Organization: Twitter
Message-ID: <1464117750.24478.104.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Keith McGuigan <kamggg@gmail.com>
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 21:22:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HuX-000169-QV
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754456AbcEXTWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:22:34 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33619 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbcEXTWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 15:22:33 -0400
Received: by mail-qk0-f177.google.com with SMTP id n63so19020898qkf.0
        for <git@vger.kernel.org>; Tue, 24 May 2016 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:organization:mime-version
         :content-transfer-encoding;
        bh=rJjh4vjfA2OfdoOvyBWcV8RlZeHc26jldjA9R/rR6vk=;
        b=KqWm2n9gtwtg2OaRDREwt3PW64Y8peLuzEtnlzq4PB2SD5LkSg2JAHeD7OnuL+Ihwr
         sJ8aH91YJU6XxzIs8iEQP2EsiCymQ2WDOpuY9X/khNrfHedwU2rSwCHMaZRaKa6J11Co
         Ed3O0CzTYGdUCChSafE2BUy/GRmDdelql2G6FrRbmJ71FmY98Y+yWvmvqRnvpNIXe8/p
         GrwP0XFLzVEppXuluy4XKucl887dQmGPTTuFWlzquRitSjwEmX8Ky7PUh2r65DoLEbe4
         OkKFai6Ptcl76ktH+8JduS2KEpuViXk85f44Nf9KupUkx7mefOizCxYMTRDQDjpYCgK1
         QEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
         :mime-version:content-transfer-encoding;
        bh=rJjh4vjfA2OfdoOvyBWcV8RlZeHc26jldjA9R/rR6vk=;
        b=DVijpmQhzBCuTNfXPe2yxp50hlzpDB3yh1uE4ClpD/cfRUEzCyIKiZj02Ri1JmHE/T
         kbBojig0hw9asgRVM7PDAcD5XtkvwM9YoFTu9cbV1GEEFhAFvT+FDe2ytnbiCRYb35Y3
         l4BKkOlbsS3jGiDwmeSjwQkMdHCf+Rd6fsSHfTxtb9K88Z6BZbzNC9QV9QZmfgVOESIq
         xidluYZxJXkLtZrGbK2EJGvU1BCtCmd851neR1VvT7yIRlqOV/vNqYmgCk6q1nEu3W6g
         +hpJinKmcxilt1ahjzj6orpkh8xNB++IAm3/S1UBmIyx3L0peixlQ2CI9U2bv/0vJkHi
         1/FQ==
X-Gm-Message-State: ALyK8tLxUIH3sLO9OZ7RJY5SE+pCNNZZgIx/Qnp0FrMT7/IOcem4rmJKHsgXQET58rjDxg==
X-Received: by 10.55.96.131 with SMTP id u125mr4920795qkb.97.1464117752415;
        Tue, 24 May 2016 12:22:32 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id k20sm1239538qtk.47.2016.05.24.12.22.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 May 2016 12:22:31 -0700 (PDT)
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295523>

June 3rd will be my last day at Twitter.  I hope that my new job
(starting in July after a month of vacation) will give me time to work
on Git, but I don't know exactly what parts I'll be working on, or on
what schedule.

As a result, some of my patchsets may get significantly less of my
attention.  Also, my twopensource.com email address will (probably) be
going away.  You can reach me on my personal email address at 
novalis@novalis.org.  

Keith McGuigan <kamggg@gmail.com> will be taking over Git work at
Twitter.  You may remember Keith from his diagnosis of the user-after
free which we fixed in "name-hash: don't reuse cache_entry in
dir_entry".  Some of you also met him at Git Merge.

Here is the status on the pending patchsets that I've worked on:

- index-helper/watchman is in pu.  Keith will be interested in
iterating on this series if necessary.

- alternate refs backends: Michael Haggerty is working on a new version
of this.  I don't know if Keith will have time to jump in on this.
Depending on the exact timing of Michael's work, I might have a chance
to do another round on this.

- Protocol v2: I would like to get a new draft of Stefan's series out
before I leave, but no promises.  It's turned out to be a bit more
complicated than I expected to support HTTP.  At worst, I'll toss my
WIP on github and send a link to the list.  

As you may have heard at Git Merge 2015, Twitter uses a journal-based
replication scheme.  We would like to switch to vanilla fetch but are
concerned about performance in the presence of many refs.  Protocol v2
could help with this.  We haven't sent the journal code to the list
because its handling of refs is suboptimal.  A LMDB refs backend would
make that much simpler.  I think I've sent a github link to the list in
the past for that code.

Keith might or might not do some work on protocol v2, depending on his
time and on how Twitter decides to handle fetching.

I've really enjoyed working on Git, and I hope I get the chance to do
more in the future.  Thanks to everyone for wonderful code reviews and
a pleasant environment.  It's been great.
