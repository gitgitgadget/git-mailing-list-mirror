X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:33:15 -0800 (PST)
Message-ID: <952802.95154.qm@web31802.mail.mud.yahoo.com>
References: <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 19:33:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Dqj9hf87tejH14MirqGz3L8IBSA9tp5OUDwESqYaVHuSC2PQyt1BIguzK3fhVL4YWeQDAS/mvKKiERQi709bfWUuguRbGr8pNvVS1O5eYvIGIpdypzyD6JKkopgPqNUmUtjY/DD/cLrswogio9vM44TOOZ+u9wSuobJEeR+CDFI=  ;
X-YMail-OSG: tPvkJ.kVM1l1_wN.n13kZHFvNnt7X_sZFn_EbeEE3C1O5botlonDGz6sEF4m07HAF16g.h7vmal_6RzO0IsbhOJAIx4n6VHhLPkFh5Vdknarg3lASQ1Mm_GiJBeWxgZPLKKDs3dSilo-
In-Reply-To: <7viri34a3k.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30445>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGPI-0000SF-Lp for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965334AbWJ2TdR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965338AbWJ2TdR
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:33:17 -0500
Received: from web31802.mail.mud.yahoo.com ([68.142.207.65]:40067 "HELO
 web31802.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S965334AbWJ2TdR
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:33:17 -0500
Received: (qmail 96313 invoked by uid 60001); 29 Oct 2006 19:33:16 -0000
Received: from [71.80.233.118] by web31802.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 11:33:15 PST
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

--- Junio C Hamano <junkio@cox.net> wrote:
> It somehow feels that deviating from what "git diff" gives makes
> it very distracting; I would feel better if "/-rw-r--r-- (file)"
> were not there.

Agree.

> Also I think arguing over 7 or 8 hexdigits is pointless; if you
> are reading this from "git diff", it is probably the easiest to
> match what "git diff" gave you.  One thing we _might_ want to do

Agree.

    Luben
