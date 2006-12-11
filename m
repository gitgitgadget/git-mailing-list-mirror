X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Mon, 11 Dec 2006 10:30:04 +0100
Organization: At home
Message-ID: <elj8af$32n$1@sea.gmane.org>
References: <20061211034018.16937.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 11 Dec 2006 09:28:10 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 25
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33985>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GthSB-0006k4-N0 for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762673AbWLKJ2B convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006 04:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762683AbWLKJ2A
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:28:00 -0500
Received: from main.gmane.org ([80.91.229.2]:35924 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762673AbWLKJ2A
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 04:28:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GthRs-0000Di-QZ for git@vger.kernel.org; Mon, 11 Dec 2006 10:27:49 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 10:27:48 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 11 Dec 2006
 10:27:48 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Side note: I wonder why this mail is not attached to the rest of thread=
 in
the gmane.comp.version-control.git news/Usenet GMane mirrot of git mail=
ing
list.

linux@horizon.com wrote:

> Oh! =A0There is no per-directory shortlog page; that simplifies thing=
s.
> But there *should* be.)

There is. It is called "history" (and currently we have only shortlog-l=
ike
view for history and no log-like view).

> The only tricky thing is the "n minutes/hours/days ago" timestamps.
> Basically, you want to generate a half-formatted, indefinitely-cachea=
ble
> page that contains them as absolute timestamps, and a have system for
> regenerating the fully-formatted page from that (and the current time=
).

Or use ECMAScript (JavaScript) for that. I plan (if this feature is
requested) to make it a %feature.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

