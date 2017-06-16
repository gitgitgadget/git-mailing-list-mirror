Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6DFB1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 12:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbdFPMSA (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:18:00 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:38882 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbdFPMR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:17:59 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jun 2017 08:17:59 EDT
Received: from tigra (unknown [192.168.2.102])
        by hermes.domain007.com (Postfix) with ESMTP id 035F1D400D0;
        Fri, 16 Jun 2017 15:09:58 +0300 (MSK)
Date:   Fri, 16 Jun 2017 15:09:57 +0300
From:   Konstantin Khomoutov <flatworm@users.sourceforge.net>
To:     =?iso-8859-1?B?Q2zpYmlvIEMu?= Felix <clebiofelix@yahoo.com.br>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] GITK don't show unstaged changes
Message-ID: <20170616120957.finyyp2mrvtc7xf2@tigra>
References: <905919609.12947564.1497527369339.ref@mail.yahoo.com>
 <905919609.12947564.1497527369339@mail.yahoo.com>
 <1527808373.12987632.1497527566906@mail.yahoo.com>
 <20170616063031.mxx72dlg5ccc3vtq@tigra>
 <1466340834.14042132.1497612459300@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1466340834.14042132.1497612459300@mail.yahoo.com>
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 11:27:39AM +0000, Clébio C. Felix wrote:

>>> Details:  https://github.com/git-for-windows/git/issues/1203 
>>> 
>>> Version with bug: 2.13.1
>>> Normal: 2.13.0
>> 
>> Attached are the pictures for those who doesn't want to browse that bug
>> and dig them up.
>> 
>> Basically, the idea is that Gitk in 2.13.1 won't show that "Local
>> uncommitted changes blah blah ..." entry above the one representing the
>> tip commit even though the `git status` command shows them.
> If this is an intentional change and not a bug, then gitk has become
> less useful to me, since I've always used it to do a quick review
> before committing. It's easier than using bash. Sad.

Hi!

Well, my message with your pic displaying the bug seemingly failed to
come through the filters of the list hosting software.

But while we're on it -- please, when you're asked to report your
problem somewhere else don't just drop a link to a prior discussion:
chances are very high, most of those who would otherwise pay attention
to your problem will simply skim over and ignore it whatsoever.

I tried to correct this without much fuss but it seems like that did not
quite work out ;-)

