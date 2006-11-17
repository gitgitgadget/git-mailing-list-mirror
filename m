X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 13:25:23 +0100
Organization: At home
Message-ID: <ejk9l0$l2s$1@sea.gmane.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611161508530.3349@woody.osdl.org> <455CFCBD.8040901@xs4all.nl> <f2b55d220611161734m49136e6fneda5b002eb67618b@mail.gmail.com> <f2b55d220611162242s48dc42d6g4cbfd9173e712ff8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 17 Nov 2006 12:24:33 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 14
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31694>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl2la-0004hu-3H for gcvg-git@gmane.org; Fri, 17 Nov
 2006 13:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755696AbWKQMYS convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006 07:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755697AbWKQMYR
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 07:24:17 -0500
Received: from main.gmane.org ([80.91.229.2]:12775 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1755078AbWKQMYR (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 07:24:17 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gl2lT-0004gF-Ho for git@vger.kernel.org; Fri, 17 Nov 2006 13:24:15 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 13:24:15 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 17 Nov 2006
 13:24:15 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Michael K. Edwards wrote:

> Currently, it looks like "remotes" entries are
> created only by "git clone" or by hand. =A0Junio, are there any plans=
 to
> manage the contents of "remotes" through the tool instead of by hand?

Don't forget quite new work with managing remotes (and per-branch
configuration) in the config instead of separate remotes/ (or even olde=
r
branches/) file
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

