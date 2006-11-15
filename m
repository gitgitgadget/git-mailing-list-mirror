X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Missing features in git
Date: Wed, 15 Nov 2006 08:35:46 +0100
Message-ID: <20061115073546.GD5453@diana.vm.bytemark.co.uk>
References: <20061114195559.40967ee4.froese@gmx.de> <20061114213800.28716.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 15 Nov 2006 07:36:17 +0000 (UTC)
Cc: git@vger.kernel.org, torvalds@osdl.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061114213800.28716.qmail@science.horizon.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31424>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkFJZ-0006XV-AT for gcvg-git@gmane.org; Wed, 15 Nov
 2006 08:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965889AbWKOHgF convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006 02:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965904AbWKOHgF
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 02:36:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:19718 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S965889AbWKOHgC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 02:36:02 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GkFJC-00065k-00; Wed, 15 Nov 2006 07:35:46 +0000
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

On 2006-11-14 16:38:00 -0500, linux@horizon.com wrote:

> It also removes a paragraph of excuses from some "using git" docs
> I'm writing. It's a lot easier to explain why you can't commit if
> you're not on a branch than to explain why you can't not be on a
> branch.

This is precisely why writing documentation is such a good idea: It is
in many cases easier to fix the warts than finding a pedagogical way
to explain them. :-)

(Well, then there's the secondary benefit that users can learn from
the docs ...)

--=20
Karl Hasselstr=F6m, kha@treskal.com
