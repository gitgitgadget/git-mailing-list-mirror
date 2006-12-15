X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add --add option to git-repo-config
Date: Fri, 15 Dec 2006 09:54:53 +0100
Organization: At home
Message-ID: <eltno8$vos$1@sea.gmane.org>
References: <75CF19E7-7953-4C0A-B4CE-E9BB6822E062@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 15 Dec 2006 08:55:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34480>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv8qW-0001ud-P9 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 09:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751315AbWLOIzJ convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006 03:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWLOIzJ
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 03:55:09 -0500
Received: from main.gmane.org ([80.91.229.2]:36258 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1751315AbWLOIzH
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 03:55:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gv8qL-0004CN-TO for git@vger.kernel.org; Fri, 15 Dec 2006 09:55:01 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 09:55:01 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 09:55:01 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Brian Gernhardt wrote:

> =A0 'git-repo-config' [--global] [type] name [value [value_regex]]
> +'git-repo-config' [--global] [type] --add name value

In few places it seems that original has one space at beginning of line=
,
and added value lacks this space.

Otherwise, very nice patch. Thanks!
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

