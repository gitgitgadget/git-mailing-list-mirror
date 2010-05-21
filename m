From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [SCM] GNU Libtool annotated tag, v2.2.7b, created. v2.2.7b
Date: Fri, 21 May 2010 11:48:08 +0200
Message-ID: <201005211148.08994.trast@student.ethz.ch>
References: <E1OFFfN-0003gH-6w@vcs-noshell.in.savannah.gnu.org> <A3F5E117-5E3D-4C9B-97A9-5C75D0ACF8E2@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <libtool-commit@gnu.org>, <git@vger.kernel.org>
To: "Gary V. Vaughan" <gary@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 21 11:48:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFOqJ-0002db-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 11:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386Ab0EUJsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 05:48:30 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:6195 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755389Ab0EUJs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 05:48:29 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 21 May
 2010 11:48:28 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 21 May
 2010 11:48:08 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <A3F5E117-5E3D-4C9B-97A9-5C75D0ACF8E2@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147444>

Gary V. Vaughan wrote:
> Git bug?  Or am I misunderstanding something?
> 
> On 21 May 2010, at 07:00, Gary V. Vaughan wrote:
> > This is an automated email from the git hooks/post-receive script. It was
> > generated because a ref change was pushed to the repository containing
> > the project "GNU Libtool".
> > 
> > The annotated tag, v2.2.7b has been created
> >        at  13412c2e2dfe7a720483c8d1dc98ca21c13c0483 (tag)
> >   tagging  99da5501fcca20d7cab7f328e223c7520c1a6701 (commit)
> >  replaces  v2.2.6
>    ^^^^^^^
> > tagged by  Gary V. Vaughan
> >        on  Fri May 21 06:26:53 2010 +0700
> 
> This implies v2.2.6 tag was removed, and v2.2.7b was created in its place.
> And yet in a freshly cloned tree I still see the v2.2.6 tag at commit
> c7f97f395615fb62c96de30c6925484ecd0cee2e.  I'm running git version 1.6.6.1.

>From a brief look at contrib/hooks/post-receive-email, this is merely
the nearest tag for 99da550^ (i.e., the "previous" tag before this)
combined with a poor choice of words.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
