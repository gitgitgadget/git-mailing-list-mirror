X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/3] Ask git for author and committer name
Date: Sun, 12 Nov 2006 00:35:38 +0100
Message-ID: <20061111233538.GC20192@diana.vm.bytemark.co.uk>
References: <20061111232322.17760.26214.stgit@localhost> <20061111233046.17760.62871.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 23:35:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061111233046.17760.62871.stgit@localhost>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31252>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj2Nz-0007NG-Iv for gcvg-git@gmane.org; Sun, 12 Nov
 2006 00:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947328AbWKKXfk convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 18:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947330AbWKKXfk
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 18:35:40 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:65038 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1947328AbWKKXfk
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 18:35:40 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gj2Nu-0005RK-00; Sat, 11 Nov 2006 23:35:38 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-12 00:30:46 +0100, Karl Hasselstr=F6m wrote:

>   1. Use the value specified on the command line, if any.
>
>   1. Otherwise, use the value from stgitrc, if available.
>
>   2. Otherwise, ask git for the value. git will produce the value
>      from on of its config files, from environment variables, or
>      make it up. It might be asking the spirits of the dead for all
>      we care.

Oops. Feel free to renumber these points as you see fit. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
