From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git survey stats
Date: Mon, 7 Sep 2009 22:00:48 +0200
Message-ID: <200909072200.49208.jnareb@gmail.com>
References: <7da341b10909071155k63ffed19q52073277b3a3bb13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Pieter de Bie <frimmirf@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 22:01:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkkP0-0003Lo-63
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 22:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbZIGUA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 16:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbZIGUA4
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 16:00:56 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:59684 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbZIGUAz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 16:00:55 -0400
Received: by bwz19 with SMTP id 19so1777763bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=EuXwNAHx49aXMXJzimmNkxAn2V9Xlle4jxUhgyEnBVA=;
        b=jiHWBLVWQNs8S4AZmx1UR3yCT70/mhvHlf6CzStjsUgDlUuYySvP+G/DxtwTETGb1O
         BEYsBaUDURU2/sqnUsKaDDqzRbAU162C1s8ZCBqay+IRxNJCfMbkPi5Jdtrzhca9jx5h
         4EUx5D90qScsvcpZiT/qiArhcVh1HOHRg860Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=Wew+mxEzrU309BoFKZ5HoXmK3aM515G2PAXjWhcvgUIFmgzEWGT1nSHMg/NvCDiOjt
         7yQgeTAZUMQD+jZdMhBlNOuM2QoXolv/JLXjP5TArOsOl46I3buovSPVWoq4D4VF0zHw
         Fi9ACbopHYMOsKvz63b55QTm2kyIlhU0NISKw=
Received: by 10.204.19.132 with SMTP id a4mr12412648bkb.21.1252353656485;
        Mon, 07 Sep 2009 13:00:56 -0700 (PDT)
Received: from ?192.168.1.13? (abwl70.neoplus.adsl.tpnet.pl [83.8.235.70])
        by mx.google.com with ESMTPS id 21sm7681564fkx.14.2009.09.07.13.00.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 13:00:54 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7da341b10909071155k63ffed19q52073277b3a3bb13@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127945>

On Mon, 7 Sep 2009, Pieter de Bie wrote:
> 
> I wondered if you could tell me what the total number of users, and
> the percentage of users use GitX, in the current survey?

You can always check it out for yourself in "live" survey summary at
http://www.survs.com/shareResults?survey=2PIMZGU0&rndm=678J66QRA2
http://tinyurl.com/GitSurvey2009Analyze

I have just updated http://git.or.cz/gitwiki/GitSurvey2009 to have
this link.

11) What Git interfaces, implementations, frontends and tools
    do you use? 
    (Choice - Multiple answers) 

============================================
Answer                         | [%] | [N]
--------------------------------------------
git (core) commandline         | 97% | 3382
JGit (Java implementation)     |  5% |  160
library / language binding     |     |
(e.g. Grit or Dulwich) 	       |  4% |  133
............................................
Cogito (DEPRECATED)            |  0% |   13
pg aka Patchy Git (DEPRECATED) |  0% |    2

Easy Git                       |  1% |   28
Pyrite                         |  0% |    6
StGIT                          |  2% |   59
Guilt                          |  0% |   13
TopGit                         |  1% |   38
............................................
gitk                           | 46% | 1593
git gui                        | 20% |  699
QGit                           |  6% |  222
GitView                        |  1% |   21
Giggle                         |  4% |  153
GitNub                         |  4% |  150
**GitX**                       | 19% |  665  <== here
git-cola                       |  2% |   56
tig                            |  6% |  198
TortoiseGit                    |  5% |  182
Git Extensions                 |  2% |   69
git-cheetah                    |  0% |    5
............................................
git-instaweb                   |  3% |   98
git-sh                         |  2% |   53
............................................
Gitosis (as admin)             | 11% |  380
repo (multiple repositories)   |  2% |   60
--------------------------------------------
editor/IDE VC integration      | 11% |  393
filemanager integration        |     | 
/ shell extension (any)        |  3% |   93
graphical history viewer       |     |
/ browser (any)                | 16% |  553
graphical commit tool (any)    |  6% |  217
graphical diff  tool           | 16% |  564
graphical merge tool           | 15% |  514
graphical blame or pickaxe tool|  2% |   82
my own scripts (for daily      |     |
commandline use, porcelain)    |  9% |  309
my own scripts                 |     | 
(for special tasks)            | 10% |  363
============================================
Other (please specify)         |  8% |  293
############################################
Total respondents              |       3473
Skipped this question          |        195
============================================

Percentage is relative to responders that answered this question.

As you can see GitX is third after (bundled) gitk and git-gui.

-- 
Jakub Narebski
Poland
