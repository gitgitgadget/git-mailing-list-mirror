X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 11:37:54 +0100
Organization: At home
Message-ID: <ejk3bf$veg$1@sea.gmane.org>
References: <20061116221701.4499.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 10:37:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 16
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31688>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl15f-00083f-Ui for gcvg-git@gmane.org; Fri, 17 Nov
 2006 11:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755691AbWKQKg5 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 05:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755692AbWKQKg5
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 05:36:57 -0500
Received: from main.gmane.org ([80.91.229.2]:21656 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755690AbWKQKg4 (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 05:36:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl15K-0007yl-5o for git@vger.kernel.org; Fri, 17 Nov 2006 11:36:39 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 11:36:38 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 11:36:38 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

linux@horizon.com wrote:

> * Remotes files
>=20
> You can specify what to fetch on the git-fetch command line. =A0Howev=
er,
> if you intend to monitor another repository on an ongoing basis,
> it's generally easier to set up a short-cut by placing the options in
> .git/remotes/<name>.

You can also set up this in config file (remote and branch sections),
in modern git.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

