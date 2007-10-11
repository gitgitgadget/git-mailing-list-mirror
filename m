From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Is it possible for git to support binary differencing for binary files?
Date: Thu, 11 Oct 2007 20:15:18 +0200
Message-ID: <20071011181518.GB2804@steel.home>
References: <20071011163746.DEB147E6F@mail.kooxoo.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?6ZO25bmz?= <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:15:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig2ZK-0006zw-Cw
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 20:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbXJKSPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Oct 2007 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755413AbXJKSPX
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 14:15:23 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49089 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbXJKSPX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 14:15:23 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (mrclete mo56) (RZmta 13.4)
	with ESMTP id 500c4bj9BF3CoK ; Thu, 11 Oct 2007 20:15:20 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 485FF277AE;
	Thu, 11 Oct 2007 20:15:18 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 283B3C50A; Thu, 11 Oct 2007 20:15:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071011163746.DEB147E6F@mail.kooxoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60621>

=E9=93=B6=E5=B9=B3, Thu, Oct 11, 2007 18:37:43 +0200:
> Hi.=20
> Storing binary files as deltas is helpful to keep source and binary f=
iles
> together and in sync  So is it possible for git to do that as svn. Th=
is is
> my only pain when using git.

Why? Git works perfectly with binary files. In fact, some of my repos
have more binaries than text.
