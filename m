X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Allow hand-editing of patches before sending
Date: Fri, 3 Nov 2006 14:42:45 +0100
Message-ID: <20061103134245.GC21202@diana.vm.bytemark.co.uk>
References: <20061101090046.1107.81105.stgit@localhost> <b0943d9e0611020232x1e343bbco9451c8183c84d68@mail.gmail.com> <20061102113631.GA30507@diana.vm.bytemark.co.uk> <b0943d9e0611030139i7be9569bh4a29596a768e82a3@mail.gmail.com> <20061103095859.GC16721@diana.vm.bytemark.co.uk> <b0943d9e0611030444w13e04586u185413c2562d45bc@mail.gmail.com> <20061103130259.GA20611@diana.vm.bytemark.co.uk> <b0943d9e0611030525t5da2cce7nf7b41323411e8d2d@mail.gmail.com> <20061103133329.GB21202@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 13:43:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103133329.GB21202@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30853>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfzK3-0006S3-DJ for gcvg-git@gmane.org; Fri, 03 Nov
 2006 14:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753026AbWKCNms convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 08:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753152AbWKCNms
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 08:42:48 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:35087 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1753026AbWKCNmr
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 08:42:47 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GfzJl-0005c3-00; Fri, 03 Nov 2006 13:42:45 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-03 14:33:29 +0100, Karl Hasselstr=F6m wrote:

> Does that mean that "stg mail" with my QP patch generates output that
> even git-am can't read? I had guessed from what you said earlier that
> git-am _could_ read them.

(Yes, I'm way too lazy. I tested the "stg mail" output by mailing
patches to myself and making sure that they looked good in my mail
reader. And by looking at the raw output quite a bit.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
