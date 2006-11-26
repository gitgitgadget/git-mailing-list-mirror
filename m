X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sun, 26 Nov 2006 10:49:01 +0100
Organization: At home
Message-ID: <ekbnr6$naq$2@sea.gmane.org>
References: <7vvel2va9d.fsf@assigned-by-dhcp.cox.net> <200611260935.43762.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 26 Nov 2006 09:47:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 11
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32340>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoGbu-0002zb-KO for gcvg-git@gmane.org; Sun, 26 Nov
 2006 10:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935303AbWKZJrf convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006 04:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935304AbWKZJrf
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 04:47:35 -0500
Received: from main.gmane.org ([80.91.229.2]:52915 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935303AbWKZJre (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 04:47:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GoGbc-0002wi-TG for git@vger.kernel.org; Sun, 26 Nov 2006 10:47:25 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 10:47:24 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 26 Nov 2006
 10:47:24 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0git-repo-config remote.=
"$origin".url "$repo" ^$ &&

Is this needed? As of now git supports I think only one URL entry per r=
emote
anyway...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

