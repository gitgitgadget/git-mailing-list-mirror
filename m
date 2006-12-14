X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: Ignoring local changes
Date: Thu, 14 Dec 2006 21:56:25 +0000 (UTC)
Message-ID: <loom.20061214T225308-91@post.gmane.org>
References: <loom.20061214T171948-279@post.gmane.org> <45817F8A.3050701@op5.se>  <9e7ab7380612140855p1f4ee6c1l5ef24c4d1d169da6@mail.gmail.com>  <4581C1D4.7080102@dawes.za.net> <9e7ab7380612141336p3b930047l3a4a76947239162f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 14 Dec 2006 21:57:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 10
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 201.37.73.219 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1) Gecko/20061010 Firefox/2.0)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34412>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyZo-0006Vb-1N for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:57:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964858AbWLNV5J convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006 16:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWLNV5I
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:57:08 -0500
Received: from main.gmane.org ([80.91.229.2]:56661 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S964858AbWLNV5H
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 16:57:07 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GuyZI-0003Aj-Uw for git@vger.kernel.org; Thu, 14 Dec 2006 22:56:47 +0100
Received: from C92549DB.poa.virtua.com.br ([C92549DB.poa.virtua.com.br]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 22:56:44 +0100
Received: from pazu by C92549DB.poa.virtua.com.br with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 14 Dec 2006
 22:56:44 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Pazu <pazu <at> pazu.com.br> writes:

> I know, could remove them only from my local branch, and never push t=
he
> commit that removed the files=E2=80=A6

And that makes me think about yet another nice feature: configure git[-=
svn] to
"block" a commit, meaning that a blocked commit would never be pushed o=
ut when
doing a git push or git-svn dcommit.

-- Pazu
