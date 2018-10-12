Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EFA41F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 08:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeJLPjb (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 11:39:31 -0400
Received: from mout.gmx.net ([212.227.17.20]:41287 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeJLPjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 11:39:31 -0400
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxu7U-1fYSiW0E32-015JgJ; Fri, 12
 Oct 2018 10:08:12 +0200
Received: from DESKTOP-QUA364F ([89.204.153.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lxu7U-1fYSiW0E32-015JgJ; Fri, 12
 Oct 2018 10:08:12 +0200
Date:   Fri, 12 Oct 2018 10:08:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Hesse <list@eworm.de>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: add build targets 'man' and 'html'
In-Reply-To: <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810121006180.45@tvgsbejvaqbjf.bet>
References: <20181007073036.30643-1-list@eworm.de> <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-972809272-1539331693=:45"
X-Provags-ID: V03:K1:dGc6AnyMfQ7ahGJcLcdMub1i+/a0gQrQGjhfqZcVFfP7o+o5F+k
 KcDGIqOpBR38pII934OxYOf5//p75qq9N4CsIpDI8sEDnUrCsW2P4J9f+tE4fYWFSWJ0N5+
 2kuz0Qkg3IEqX17htOd9MRPdoKY2tXMCakU5CR04O5CO5VLdvBfYGn9gMZwqYh3P1BURc5d
 MEznuZ16+dbJw5rBwGhIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZGMbxkjZFs0=:hsB4fopfiT3pfVq33AMe+s
 tgwHCZlMnIMgSZJb0pEP/s/D7rxVpC1dVbKW+Y10vISodoaMs+N+LiFxW3J2DtHorQ7bgG+mk
 ioroQpEcgu6v7elhwMiKWAYpV4qsNuZmedAmrbAFxqVa5/ZBHCeKBU8sy3jQpezH+Gibzkb+7
 NgCvoi4cfEq6E5FM1YY5TCUq/kw8CFTZOEF19MkKNZ6ZKTqUYEyi0CsnvBznd9AphF8O3i/81
 D7GnHNUU6cN+5D33NVpyEKJB8h2KtgLwlpDm9wLuEvCb1aw86I2Q41x/6RDZBcc15wwX6DVa2
 TuaD/4uMomYheE+TvqAB6aNVBCcq6hh5HAR52KQgSbDRo7FgN1dLxTfAf0S0hEB8JcNkTJdDV
 4rvMbWj4Hv36xkzwvVyVqdwcavLFJaKk4hoAkp4f+AQ0hvFMNRjMwZRQlycUXkYbB9rmph4MM
 w6Pc8x5Nr9Yv29dxULMUoNviG5RI1eXhsR0xRk+tlcT/oyINpwGEKuV5pBYOi4jMKOgkY7DDH
 NBwWRrfqo97FLGDSGqsbjBj24YAEGTsTlz8+uck+YCL9Wt0D1z65LF7kxtpevqCbxTBpkX+lj
 g8PdXj74fyVMJk9POIuP5XE6LzOVY4BNRprnnP7uN+4GJbyLSj1DKZAUyHqMYhKHX+cVtBtgj
 BfrSEe/ySkkXDjW39/VNV3cafL4Qln6OfBuh/rmUwd3gPWMqqWtjVitIPjMgfcEQJ+d9vgmi1
 Wny6JFXZb8Z5Gf4kZyOkKPOsGz929JfaRhUT1a+wbj0WKBaFgd0jLU/8xndbmoOBYrs4PxMBT
 1VAZnVQW47DwqmEPSdcPHpG1tvUqxOYx/B9/UupCOnRdIONChY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-972809272-1539331693=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 10 Oct 2018, Junio C Hamano wrote:

> Christian Hesse <list@eworm.de> writes:
> 
> > From: Christian Hesse <mail@eworm.de>
> >
> > We have targets 'install-man' and 'install-html', let's add build
> > targets as well.
> >   ...
> > +man: $(GIT_SUBTREE_DOC)
> > +
> > +html: $(GIT_SUBTREE_HTML)
> > +
> 
> As 'contrib' material without real maintenance, I do not care too
> deeply, but shouldn't this change be more like this to avoid
> duplicating the list of targets?

Ævar mentioned that he'd like this to graduate from contrib into core, and
I had briefly looked at making subtree a built-in to that end. IOW please
do not get too used to subtree being in contrib.

Ciao,
Dscho

> 
> 
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 5c6cc4ab2c..4a10a020a0 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -59,17 +59,21 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
>  
>  doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
>  
> +man: $(GIT_SUBTREE_DOC)
> +
> +html: $(GIT_SUBTREE_HTML)
> +
>  install: $(GIT_SUBTREE)
>  	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
>  	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(gitexecdir)
>  
>  install-doc: install-man install-html
>  
> -install-man: $(GIT_SUBTREE_DOC)
> +install-man: man
>  	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
>  	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
>  
> -install-html: $(GIT_SUBTREE_HTML)
> +install-html: html
>  	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
>  	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
>  
> @@ -94,4 +98,4 @@ clean:
>  	$(RM) $(GIT_SUBTREE)
>  	$(RM) *.xml *.html *.1
>  
> -.PHONY: FORCE
> +.PHONY: FORCE man html install-man install-html
> 
> 
--8323328-972809272-1539331693=:45--
