Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D920E20984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759402AbcIMQzf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:55:35 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:43839 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756837AbcIMQze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:55:34 -0400
Received: (qmail 9268 invoked from network); 13 Sep 2016 16:54:34 -0000
Received: (qmail 17778 invoked from network); 13 Sep 2016 16:54:34 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 13 Sep 2016 16:54:29 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1473785665.7329.22.camel@sapo.pt>
Subject: Re: [PATCH v2 07/14] i18n: merge-recursive: mark error messages for
 translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>
Date:   Tue, 13 Sep 2016 16:54:25 +0000
In-Reply-To: <xmqqinu13y0x.fsf@gitster.mtv.corp.google.com>
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
         <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
         <1473679802-31381-7-git-send-email-vascomalmeida@sapo.pt>
         <xmqqinu13y0x.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Seg, 12-09-2016 às 09:04 -0700, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> > Lowercase first word of such error messages following the usual
> > style.
> 
> "Change X to lowercase" is fine, but "Lowercase" is not a verb.
> 
> Reword it to "Downcase the first word...", perhaps (not limited to
> this step).

Lowercase is a verb [1] meaning to print or write with a lowercase
letter or letters. Knowing that can the commit message be kept?

[1] http://www.dictionary.com/browse/lowercase
