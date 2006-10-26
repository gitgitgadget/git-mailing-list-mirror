X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/3] make =?iso-8859-1?Q?index-?=
	=?iso-8859-1?Q?p=E2ck?= able to complete thin packs
Date: Thu, 26 Oct 2006 11:19:25 +0200
Message-ID: <20061026091925.GD13780@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0610252323100.12418@xanadu.home> <7vr6wvr1ca.fsf@assigned-by-dhcp.cox.net> <ehppbg$phq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 09:19:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ehppbg$phq$1@sea.gmane.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30162>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1Oo-0000DC-Rs for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752138AbWJZJT3 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 05:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWJZJT2
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:19:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:38156 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752139AbWJZJT0
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:19:26 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd1OX-0003lA-00; Thu, 26 Oct 2006 10:19:25 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-10-26 09:50:48 +0200, Jakub Narebski wrote:

> That said, git-am should understand QP with coding in mail headers.

I really hope it does, since I just patched StGIT to generate such
headers. (Out of pure vanity -- I don't want my name mangled!)

--=20
Karl Hasselstr=F6m, kha@treskal.com
