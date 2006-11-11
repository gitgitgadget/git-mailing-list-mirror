X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Author name and e-mail address in .stgitrc
Date: Sat, 11 Nov 2006 15:57:08 +0100
Message-ID: <20061111145708.GH11224@diana.vm.bytemark.co.uk>
References: <20061111113553.GA11224@diana.vm.bytemark.co.uk> <20061111141530.GF11224@diana.vm.bytemark.co.uk> <200611111531.16304.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 14:57:42 +0000 (UTC)
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611111531.16304.robin.rosenberg.lists@dewire.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31228>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GiuIV-00033J-3C for gcvg-git@gmane.org; Sat, 11 Nov
 2006 15:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754833AbWKKO5U convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 09:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbWKKO5U
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 09:57:20 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14859 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1754833AbWKKO5T
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 09:57:19 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GiuI9-0003ws-00; Sat, 11 Nov 2006 14:57:09 +0000
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

On 2006-11-11 15:31:15 +0100, Robin Rosenberg wrote:

> l=F6rdag 11 november 2006 15:15 skrev Karl Hasselstr=F6m:
>
> > Is there any particular reason to have the author and committer
> > names in ~/.stgitrc? Simply taking them from the same place git
> > does would probably be a usability enhancement (unless they're
> > specified on the command line, of course).
>
> AFAIK StGit already does that, at least if you (like me) do not have
> a .stgitrc.

But I haven't gotten the impression that specifying them in ~/.stgitrc
is deprecated. The example stgitrc has a section with author name and
committer name, for example.

--=20
Karl Hasselstr=F6m, kha@treskal.com
