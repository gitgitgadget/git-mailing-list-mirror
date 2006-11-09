X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: "Horst H. von Brand" <vonbrand@laptop13.inf.utfsm.cl>
Subject: Re: What's in git.git
Date: Wed, 08 Nov 2006 23:28:22 -0300
Message-ID: <200611090228.kA92SMqw006666@laptop13.inf.utfsm.cl>
References: <dlang@digitalinsight.com>
NNTP-Posting-Date: Thu, 9 Nov 2006 02:29:37 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: Message from David Lang <dlang@digitalinsight.com> 
   of "Tue, 07 Nov 2006 20:13:10 -0800." <Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31175>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghzfa-0007TF-Qb for gcvg-git@gmane.org; Thu, 09 Nov
 2006 03:29:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754690AbWKIC3X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 21:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbWKIC3X
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 21:29:23 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:15628 "EHLO
 pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP id S1754690AbWKIC3X
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 21:29:23 -0500
Received: from laptop13.inf.utfsm.cl (as5300-s60-113.cnt.entelchile.net
 [164.77.158.123]) by pincoya.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id
 kA92SxD5007793; Wed, 8 Nov 2006 23:29:09 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1]) by
 laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id kA92SMqw006666; Wed, 8
 Nov 2006 23:28:27 -0300
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

David Lang <dlang@digitalinsight.com> wrote:
> On Tue, 7 Nov 2006, Junio C Hamano wrote:
> 
> > [pu]
> >
> >  Johannes's shallow clone work now should rebase cleanly on top
> >  of 'master' although I haven't done so yet.  As he said
> >  himself the series is waiting for people who have needs for
> >  such a feature to raise hands.
> 
> I haven't been watching this recently, but if this is what I
> understand it to be (the ability to get a partial repository from
> upstream and work normally from there with the result of data-mineing
> tools sometimes reporting 'that's part of the truncated history' if
> they hit the cutoff) consider my hand raised.

+1
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
