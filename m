From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Extract remaining classes from git-svn
Date: Fri, 27 Jul 2012 13:29:52 +0200
Message-ID: <CABPQNSYjvW9GZs18j+m4mUT6jiJ5VTUdnyi-L5Q8tHeqE7R+tg@mail.gmail.com>
References: <1343348767-86446-1-git-send-email-schwern@pobox.com> <5011E07A.807@pobox.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net,
	jrnieder@gmail.com
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 13:30:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Suikh-0004Gq-0S
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 13:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2G0Lae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jul 2012 07:30:34 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:59226 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609Ab2G0Lad (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2012 07:30:33 -0400
Received: by vcbfk26 with SMTP id fk26so2598537vcb.19
        for <git@vger.kernel.org>; Fri, 27 Jul 2012 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ut435hKT4L1H5xh1xcVIbXrqDuuntQor9StV1uxFyug=;
        b=l0HneSEiWu7jxpVK7YI6KgtOOH4HZiYtHi2BTtqjJf8BlM/0e1lMK0I3WGuLpqaNsD
         JSfeT5YRVxsLon4YKFiePz6AhszD9xRYX3gg1hJyAWaRsBOGCnUZPIknSi9uIz+N6El5
         28eN5UV7GV2xj1o/a/Mo2YppeficgQgQiAzLNUS1UtaorSk18jkNKS7h7MnXmmWdTK+H
         smA3tjvvt1mXjFTr8I48uBLqCal0AIXUKbC7RxoMv3b/jtLdcK8m2PGtjV9Az0Rrh9n3
         QAB59Io63qapJ4ner6rU3l6dJ1M0Ps51tFHJZFHISK9cC70ehi6FEUzwWaA84l78lK7n
         Fccw==
Received: by 10.52.90.52 with SMTP id bt20mr1851553vdb.42.1343388632477; Fri,
 27 Jul 2012 04:30:32 -0700 (PDT)
Received: by 10.58.35.207 with HTTP; Fri, 27 Jul 2012 04:29:52 -0700 (PDT)
In-Reply-To: <5011E07A.807@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202348>

On Fri, Jul 27, 2012 at 2:27 AM, Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.26 5:25 PM, Michael G. Schwern wrote:
>> This series of patches extracts the remaining classes from git-svn.  They're
>> all simple extractions and functionally have no change.
>
> PS  This is on top of the previous Git::SVN extraction patch series.
>

Nice :-)

Do you have somewhere I can pull this from? I have a git-svn topic
that I suspect will be much easier to maintain on top of these
patches.
