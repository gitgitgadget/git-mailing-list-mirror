From: Stefan Beller <sbeller@google.com>
Subject: Re: Gsoc 16
Date: Tue, 15 Mar 2016 14:33:34 -0700
Message-ID: <CAGZ79ka9kKm69wdM+KhiTi8im72mMBmxY6VDuNJf6wh1baFWJw@mail.gmail.com>
References: <loom.20160315T215800-306@post.gmane.org>
	<CAFZEwPMKi5QVxNXV_nchK29OMmXpRbwvfuvfKQk52YjsKk-Q_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Saurabh Jain <saurabhsuniljain@gmail.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>, cmn@dwim.me
X-From: git-owner@vger.kernel.org Tue Mar 15 22:33:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwb0-0000E6-FB
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbcCOVdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:33:36 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35573 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370AbcCOVdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:33:35 -0400
Received: by mail-io0-f173.google.com with SMTP id g203so40747705iof.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=E79qqN40IxU3nMfGMgTFi2GTfWMAl8nzr048m/H8kDA=;
        b=BTX1+AKdgKXyM3fQK8KM+AuU02adGRC9Z8SaGzVPN8uWsmQ+7iHHwGvtAimIvG1CPE
         PdU6Sy6XBLDvrZvrp/22fTTyFda//oWKhmpCQGqOHXYApVa6zcbL9NF+F9ydlvDHpUyP
         QeiBa7F27qE5VB0rHHgwS5bHAOhNRke9G3ZWAgWKKdHUSsWnhF/BQtbpo7pw4As6+DiC
         KgPpGSn6SHnYVT7mzCw0m1L2WHsNY8TyK00bdWJhXNMNMrgDRfVTsKV4jC3hwcM2Vb0v
         IDt74sBA9+CM1U15fR7VgpQuIV0IaCFnNesvlCnNCfD2vDJu3J8bF+C9EmEajO3D2RQb
         alcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=E79qqN40IxU3nMfGMgTFi2GTfWMAl8nzr048m/H8kDA=;
        b=L9Kda6Bib8h78qEUl1m5ei0ks5ZIRUL8bMF8U9RyT+4eVjaV6Xh9fGY8ev8w8AGFns
         UBhvwwRpa7RhaU8zt/eFJHB5aySoQQgSGpRB0N9QhqRoHd0fEpXFVWzbQz4ADry+19ax
         IRsV2G4jo3iJ3odibiKQR94zpFTFVU+lK1td3Qjub5CQ97GE7oliypmDBJMUwPnPhjim
         ALF/kZ+3hS1wkELAZ4ITGU2d7jqovTcEvfwojKheZ+t6VEKev6ClP5eEuxXbcunaRN8P
         +/ti6ZW3RJiV4M05dqnmIagTmP2yg1SS5V574DEmSYWUElbRPGEWmRQEIpOKmskS6moj
         IVqA==
X-Gm-Message-State: AD7BkJJFZHZvid5dDmFr2QGXYRU7co6S/69H/qfjsEAND75ACndzLhM1HtTDpa5LQLArjxR7k7DkK//ZPccfnaY4
X-Received: by 10.107.135.96 with SMTP id j93mr940401iod.96.1458077614206;
 Tue, 15 Mar 2016 14:33:34 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 15 Mar 2016 14:33:34 -0700 (PDT)
In-Reply-To: <CAFZEwPMKi5QVxNXV_nchK29OMmXpRbwvfuvfKQk52YjsKk-Q_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288917>

On Tue, Mar 15, 2016 at 2:23 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Hey,
>
> Open Source projects run because of people who contribute in their
> free time (mainly). It might not be possible for someone to be active
> all times Sometimes it may take around 2-3 days. Give it a little more
> time.

Adding to that: Not everybody reads the whole list.
The first mail you sent, was deep down in the thread for rewriting
rebase --interactive in C instead of shell. The libgit2 maintainer (Carlos)
is highly unlikely to read that as it doesn't affect libgit2.

Posting as a separate thread here increases the chance for him to spot this
message.

Usually you'd cc the people you're addressing as that has highest chance that
the relevant people see your message. (I cc'd Carlos in this message, no need
to resend a third time from you.)

Stefan

>
> On Wed, Mar 16, 2016 at 2:30 AM, Saurabh Jain
> <saurabhsuniljain@gmail.com> wrote:
>> hi,
>>
>> I am Saurabh Jain, 3rd year Computer Science and Engineering student
>> studying at Indian Institute of Technology, Roorkee. I am quite fluent with
>> C programming.
>>
>> I would like to apply for GSoC 2016 under Git in libgit2. I read the list of
>> possible projects and microprojects to be done.
>> I tried to fix this, "Fix the examples/diff.c implementation of the -B"
>> given in Starter Projects, I made some changes to the code and created a
>> Issue on the libgit2's Github repository. But no one seems to reply to that,
>> also the IRC channel for libgit2 seems to be inactive. Please someone
>> concerned have a look.
>>
>> <https://github.com/libgit2/libgit2/issues/3686>
>>
>> I would also like to know who will be going to mentor GSoC 2016, libgit2
>> projects so that I would be able to discuss my ideas with them.
>>
>> All the concerned Mentors you can drop me a mail at saurabhsuniljain@gmail.com
>>
>> Hoping for a positive response from your side.
>>
>> Have a nice day !
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
