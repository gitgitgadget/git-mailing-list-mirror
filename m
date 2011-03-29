From: Karol Samborski <edv.karol@gmail.com>
Subject: Re: GSoC 2011
Date: Tue, 29 Mar 2011 14:10:12 +0200
Message-ID: <AANLkTi=f36g6JTmN_NKkqfJjhPPTTVm-Ufi8xV=XZjAq@mail.gmail.com>
References: <AANLkTikQ6=CrWuMemwv38HnBKPnt8CjQWqYj7oA8zVZ4@mail.gmail.com>
	<AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
	<AANLkTikM7C_h5cwgd5KoddBUH3xsdwtBiGwM_2ecKR2k@mail.gmail.com>
	<AANLkTin9REqDJhWbQ2JbESufcg6hSf6cw3NpiamXvkU_@mail.gmail.com>
	<AANLkTi=5m8t0bknk1VnTmrhwOLeZua9650tDHkM6J+BS@mail.gmail.com>
	<AANLkTimCBFDiZrcPEucqHR8Aze9W6=Yx3zKitQMTtx5a@mail.gmail.com>
	<AANLkTin=JnXO7k-NNcHVksDcM7yer=9oh3Eu9McLS15_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 29 14:10:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Xkc-0007oJ-Ra
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 14:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab1C2MKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 08:10:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61546 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750Ab1C2MKO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 08:10:14 -0400
Received: by bwz15 with SMTP id 15so118573bwz.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 05:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=xoEEfQJeZfxy3wFLnYpnNk5QrfpEeoDkBgu9kGfknJg=;
        b=jpYr9WNP4If+2OAFgNARj0A2Ta72TGvCKBACkMEYUCHy0Jutlf/miUBCIBtJKmXRbP
         O99PYEzjjdQcpwoEczbNlKfXmLiYpGyen0H7suTQcpRz+YlBBb9qrHcjBARlDSftmcLB
         31XIjBTrjpyPZ8uPyPE67PeYCfGjEXGrqiM7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=kXv5R5t+3nDwqHzRsbHVfKS/xO/mRGoiuFnZIaInUVLiUE16OQbmQOqHKXu8x/ktER
         R3Zb1ri3EDexld+ZmdOmtxHiRl+fyL9ekyhOHPTWgb6pc17PGNn/l1rI3W5KROHbZkLp
         UPcO4W6/kg+rzXARcrFDbQRCXcUpUhxgDZmfM=
Received: by 10.204.25.194 with SMTP id a2mr4885884bkc.197.1301400612707; Tue,
 29 Mar 2011 05:10:12 -0700 (PDT)
Received: by 10.204.240.17 with HTTP; Tue, 29 Mar 2011 05:10:12 -0700 (PDT)
In-Reply-To: <AANLkTin=JnXO7k-NNcHVksDcM7yer=9oh3Eu9McLS15_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170260>

2011/3/29 Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> On Tue, Mar 29, 2011 at 2:08 PM, Karol Samborski <edv.karol@gmail.com> wrote:
>> I heard that it is needed to put 40 hours per week in summer time to
>> participate GSoC program.
>> It is impossible in my case so I'll become a contributor outside the
>> GSoC program.
>
> You're welcome!
>
>> My question is: should I work on rewriting git commands to C (this
>> task is on GSoC 2011 ideas page) or leave this task for students from
>> GSoC program?
>
> I bet converting small scripts now won't hurt anybody (it's not large
> enough for GSoC work anyway, git-repack.sh for instance). It will help
> you get familiar with the code base and can keep you busy until GSoC
> really starts. By then we'll know what commands are taken by students.
> --
> Duy
>

Thank you for your answer. Of course I will get familiar with the code
base first by sending simple patches to the mailing list for review ;)
Your proposal sounds very good so I will start with rewriting
git-repack.sh or another small script.

Regards,
Karol
