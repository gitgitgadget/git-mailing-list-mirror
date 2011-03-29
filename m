From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC 2011
Date: Tue, 29 Mar 2011 18:54:27 +0700
Message-ID: <AANLkTimCBFDiZrcPEucqHR8Aze9W6=Yx3zKitQMTtx5a@mail.gmail.com>
References: <AANLkTikQ6=CrWuMemwv38HnBKPnt8CjQWqYj7oA8zVZ4@mail.gmail.com>
 <AANLkTikC5cagS8qYPDmWO+jhC4pHMkJq6zQN3QemMhwG@mail.gmail.com>
 <AANLkTikM7C_h5cwgd5KoddBUH3xsdwtBiGwM_2ecKR2k@mail.gmail.com>
 <AANLkTin9REqDJhWbQ2JbESufcg6hSf6cw3NpiamXvkU_@mail.gmail.com> <AANLkTi=5m8t0bknk1VnTmrhwOLeZua9650tDHkM6J+BS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Karol Samborski <edv.karol@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 13:57:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4XXk-000218-27
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 13:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782Ab1C2L47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 07:56:59 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57000 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab1C2L46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 07:56:58 -0400
Received: by gxk21 with SMTP id 21so24878gxk.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=PSmY9xwQs3FD9ggGPGIncpAExFLpwVuJLaG8CfE3Hjc=;
        b=N1oEgy9lUKYE4uSDT0T39QPvwuU4X9ge+XOGqAh3dvfUobgiVXCyJSgTpgv8wtka7A
         gNnDM32HaqeFbG57+aQChDZoIDxQiT6L1wAM0Dt2/E1qMTTfnXB0/IESG6uzF0NJ4ADu
         l3yeL/N5EMC5mUbXMxKZGxyDvioMDYlEtjJEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=smq43eQCBbBGQ8vDep5Knt1eLH3HjwpnDWBRk9+HD+mjoDMmNrXvwuFHwtIObEXr77
         4jveSW8TLw9Hs3MYI6wRzX2u56rnHWmr5Rs6Fi+Bj3/l3DJYTRyiU0g0/oOLO/upt6zR
         NY0d35UzZ26O9b/1rFBClIu8lDSG2mSxxOGMI=
Received: by 10.150.215.16 with SMTP id n16mr4883802ybg.224.1301399697209;
 Tue, 29 Mar 2011 04:54:57 -0700 (PDT)
Received: by 10.151.85.15 with HTTP; Tue, 29 Mar 2011 04:54:27 -0700 (PDT)
In-Reply-To: <AANLkTi=5m8t0bknk1VnTmrhwOLeZua9650tDHkM6J+BS@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170258>

On Tue, Mar 29, 2011 at 2:08 PM, Karol Samborski <edv.karol@gmail.com> wrote:
> I heard that it is needed to put 40 hours per week in summer time to
> participate GSoC program.
> It is impossible in my case so I'll become a contributor outside the
> GSoC program.

You're welcome!

> My question is: should I work on rewriting git commands to C (this
> task is on GSoC 2011 ideas page) or leave this task for students from
> GSoC program?

I bet converting small scripts now won't hurt anybody (it's not large
enough for GSoC work anyway, git-repack.sh for instance). It will help
you get familiar with the code base and can keep you busy until GSoC
really starts. By then we'll know what commands are taken by students.
-- 
Duy
