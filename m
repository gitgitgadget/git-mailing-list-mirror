X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 11:48:58 +0100
Message-ID: <20061115104858.GG5453@diana.vm.bytemark.co.uk>
References: <87k61yt1x2.wl%cworth@cworth.org> <200611150917.23756.andyparkins@gmail.com> <ejeocl$vrj$1@sea.gmane.org> <200611151033.57415.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 10:49:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611151033.57415.andyparkins@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31435>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkIKd-000697-5g for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966769AbWKOKtB convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 05:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966770AbWKOKtA
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:49:00 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:59143 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S966769AbWKOKtA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:49:00 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GkIKA-0006jr-00; Wed, 15 Nov 2006 10:48:58 +0000
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-15 11:33:55 +0100, Andy Parkins wrote:

> But that is not necessarily /the/ original, and "origin" is the
> absolute reference in maths. It doesn't bother me that much I
> suppose, it's just that as far as unambiguous names go, I'm not wild
> about it - it's got too many "central repository" connotations,
> which is of course anathema to git.

To me, "origin" just means "where <whatever we're talking about>
originated". If you think of it that way, it's perfectly obvious that
each repository can have its own origin.

--=20
Karl Hasselstr=F6m, kha@treskal.com
