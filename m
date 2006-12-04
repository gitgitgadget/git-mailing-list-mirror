X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Juergen Stuber <juergen@jstuber.net>
Subject: Re: jgit performance update
Date: Mon, 04 Dec 2006 21:35:49 +0100
Message-ID: <87ac23qtzu.fsf@freitag.home.jstuber.net>
References: <20061203045953.GE26668@spearce.org> <ekv34g$mck$1@sea.gmane.org>
	<874psceh4z.fsf@freitag.home.jstuber.net>
	<200612040039.00315.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 20:37:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 29
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54aebd03.dip0.t-ipconnect.de
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:Iu+f3c+EzKk4rSEKt0jXHD2ThrA=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33242>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrKYx-0000qp-64 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 21:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966969AbWLDUhB convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 15:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966975AbWLDUhA
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 15:37:00 -0500
Received: from main.gmane.org ([80.91.229.2]:46420 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S966969AbWLDUg7
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 15:36:59 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GrKYT-0006uu-85 for git@vger.kernel.org; Mon, 04 Dec 2006 21:36:49 +0100
Received: from p54aebd03.dip0.t-ipconnect.de ([84.174.189.3]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 21:36:49 +0100
Received: from juergen by p54aebd03.dip0.t-ipconnect.de with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Mon, 04 Dec 2006
 21:36:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hej Robin,

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> s=C3=B6ndag 03 december 2006 23:42 skrev Juergen Stuber:
>> Jakub Narebski <jnareb@gmail.com> writes:
>> > GitWiki tells us about egit/jgit repository at
>> >   http://www.spearce.org/projects/scm/egit.git
>>
>> I tried to access that with git 1.4.4.1 from Debian but
>>
>> % git clone http://www.spearce.org/projects/scm/egit.git
>>
>> hangs, the first time after "walk
>> e339766abc2b919e7bb396cae22ddef065821381", the second time after "wa=
lk
>> 9eec90ec5da239e063eaff6305d77294dc03396e" which is the "walk" line j=
ust
>> before it.
> Works fine here. (git 1.4.4.gf05d).

now it works fine for me, too.


Tack

J=C3=BCrgen

--=20
J=C3=BCrgen Stuber <juergen@jstuber.net>
http://www.jstuber.net/
gnupg key fingerprint =3D 2767 CA3C 5680 58BA 9A91  23D9 BED6 9A7A AF9E=
 68B4
