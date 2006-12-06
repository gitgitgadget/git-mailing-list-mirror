X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git pull and merging.
Date: Wed, 06 Dec 2006 11:28:00 +0100
Organization: At home
Message-ID: <el65rh$tfj$3@sea.gmane.org>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com> <7vodqhaa7o.fsf@assigned-by-dhcp.cox.net> <cc723f590612052121u1f6e3c9lc7329f40ee1c9e5a@mail.gmail.com> <Pine.LNX.4.63.0612061019350.28348@wbgn013.biozentrum.uni-wuerzburg.de> <cc723f590612060205p1fd26cd7u3c7efc723b0177de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 6 Dec 2006 10:30:11 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 18
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33430>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gru2T-00038N-4f for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760457AbWLFKaG convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006 05:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760460AbWLFKaF
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:30:05 -0500
Received: from main.gmane.org ([80.91.229.2]:37686 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760457AbWLFKaE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:30:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1Gru2M-0007QC-O2 for git@vger.kernel.org; Wed, 06 Dec 2006 11:30:02 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 11:30:02 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Wed, 06 Dec 2006
 11:30:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Aneesh Kumar wrote:

> [branch "devel"]
> =A0 =A0 =A0 =A0 remote =3D origin
> =A0 =A0 =A0 =A0 merge =3D devel

Does

  [branch "refs/heads/devel"]
        remote =3D origin
        merge =3D refs/remotes/origin/devel

works?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

