From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Which VCS besides git?
Date: Tue, 2 Mar 2010 07:41:28 -0800
Message-ID: <20100302154128.GE28997@spearce.org>
References: <201003021455.52483.karlis.repsons@gmail.com> <20100302152821.GD28997@spearce.org> <201003021538.15276.karlis.repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: K??rlis Repsons <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 16:41:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmUE8-0000RE-2j
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 16:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab0CBPlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 10:41:35 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:57580 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab0CBPlf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 10:41:35 -0500
Received: by qyk9 with SMTP id 9so175365qyk.5
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 07:41:34 -0800 (PST)
Received: by 10.224.97.146 with SMTP id l18mr3360351qan.298.1267544491480;
        Tue, 02 Mar 2010 07:41:31 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 20sm4226547iwn.1.2010.03.02.07.41.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 07:41:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201003021538.15276.karlis.repsons@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141403>

K??rlis Repsons <karlis.repsons@gmail.com> wrote:
> On Tuesday 02 March 2010 15:28:21 Shawn O. Pearce wrote:
> > K??rlis Repsons <karlis.repsons@gmail.com> wrote:
> > > which VCS besides git provide chaining of commits with help of some
> > > cryptographic hash function, warning about or not allowing commits to be
> > > deleted on an equivalent of pull action, so that all added pieces of data
> > > can be retained securely on client side?
> > 
> > Most of the distributed VCS systems do this.  I know Mercurial is
> > functionally identical to Git in this regard.  Maybe even Monotone
> > and Bazaar are as well, but I'm less familiar with those.
> 
> And svn doesn't?

I don't know about SVN.  I only used it for a few months between
CVS and BitKeeper.  After that, I jumped pretty fast into Git and
didn't care about how Subversion works internally.

You might want to ask on the SVN mailing list rather than the Git
mailing list about SVN specific details...

-- 
Shawn.
