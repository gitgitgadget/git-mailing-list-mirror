X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Subprojects tasks
Date: Sat, 16 Dec 2006 19:45:11 +0100
Organization: At home
Message-ID: <em1erl$pne$1@sea.gmane.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 16 Dec 2006 18:45:37 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34634>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GveXO-0000VD-73 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 19:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161360AbWLPSpY convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006 13:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161357AbWLPSpX
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 13:45:23 -0500
Received: from main.gmane.org ([80.91.229.2]:32832 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1161361AbWLPSpV
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 13:45:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GveXA-0004Mf-9c for git@vger.kernel.org; Sat, 16 Dec 2006 19:45:20 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 19:45:20 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 16 Dec 2006
 19:45:20 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> =A0(1) Look at the directory the "link" is at, and find .git/
> =A0 =A0 =A0subdirectory (that is the $GIT_DIR for the subproject) and
> =A0 =A0 =A0its .git/HEAD;

Or .gitlink file, if we decide to implement it (as lightweight checkout=
 and
support for submodules which one can easily move/rename).
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

