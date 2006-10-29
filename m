X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:43:14 -0800 (PST)
Message-ID: <539418.62803.qm@web31807.mail.mud.yahoo.com>
References: <200610291635.09525.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 19:43:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=f5aQsWCsyAMmA0OfGK2adMW2KZ7a64/hPBsc/kJ1bH5BOFjxOcp29ldSacpdbH+dQmIkDo1IRQDnozQJG1B/CBhXEGi4U0NGl4wz5EIp0jo5oC4fPBhd1Ewb1VSrjPBcMDJ6adYP6vGdzCsrU3vkDIf4OigM5dOUbEltVm3MZNs=  ;
X-YMail-OSG: O4DrqPwVM1kTUMdBS8pqkFDUc1xuzZ4WjG.a9DrB3nsKqqsGVP8IMKuZKSxXrDjBCvBwlaDRJZNkzNB_RuGMQqMdme.RHzuTtlySyHfbKe0cgop_SJPDSk6vBLMEfif856xJYtMt_3Q-
In-Reply-To: <200610291635.09525.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30448>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGZ8-0002mT-F3 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965358AbWJ2TnR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965360AbWJ2TnR
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:43:17 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:55928 "HELO
 web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S965358AbWJ2TnP
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:43:15 -0500
Received: (qmail 63158 invoked by uid 60001); 29 Oct 2006 19:43:14 -0000
Received: from [71.80.233.118] by web31807.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 11:43:14 PST
To: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano wrote:
> > Jakub Narebski <jnareb@gmail.com> writes:
> > 
> >> Changes:
> [...]
> >> * <file> hyperlinking should work also when <file> is originally
> >>   quoted. For now we present filename quoted. This needed changes to
> >>   parse_difftree_raw_line subroutine.
> > 
> > This feels Ok.
> 
> Emphasisis on "should". Check
>   http://roke(.)dyndns(.)info/cgi-bin/gitweb/gitweb.cgi?p=git.git;a=commitdiff;h=gitweb/test
> 
> By the way, should we use quoted or unquoted filename?

For dear life, I cannot understand  *WTF*  is this argument about
"quoted" and "unquoted".  Can this stop please?  PLEASE?

Unquoted, natural, normal.

    Luben
P.S. I don't want to punish the good people who do not put \n or \r or whatnot
in their filenames, just for this one ... "person" who does.  UTF8 is a different
story.
