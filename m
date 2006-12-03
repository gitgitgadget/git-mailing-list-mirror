X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 02:11:16 +0100
Message-ID: <200612030211.17159.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <Pine.LNX.4.64.0612021245081.3476@woody.osdl.org> <20061202205853.GW18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 01:12:11 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, sf <sf-gmane@stephan-feder.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #352111
User-Agent: KMail/1.9.3
In-Reply-To: <20061202205853.GW18810@admingilde.org>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33074>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqftT-0000S4-Hq for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936608AbWLCBLg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 20:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936609AbWLCBLg
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:11:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:7060 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S936608AbWLCBLf (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:11:35 -0500
Received: (qmail invoked by alias); 03 Dec 2006 01:11:33 -0000
Received: from p5496B2C8.dip0.t-ipconnect.de (EHLO noname) [84.150.178.200]
 by mail.gmx.net (mp001) with SMTP; 03 Dec 2006 02:11:33 +0100
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Saturday 02 December 2006 21:58, Martin Waitz wrote:
> So I was not against the link object itself (initially I wanted to do it
> this way, too), only agains the information which was proposed to be
> stored there.  Up to now I haven't found anything which makes sense to
> store next to the submodule commit to define the identity of the
> submodule.

Isn't it enough reason that a porcelain probably wants to store meta
information for a given submodule, giving the need to put a name/identity
to it?

Josef
