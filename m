From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/4] git.el: Support for showing unknown/ignored directories.
Date: Fri, 22 Feb 2008 18:10:52 +0100
Message-ID: <20080222171052.GA23012@diana.vm.bytemark.co.uk>
References: <87zludorqs.fsf@wine.dyndns.org> <20080222153051.GA20984@diana.vm.bytemark.co.uk> <8763whkmxf.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:11:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbR4-0000we-GG
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbYBVRLJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 12:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbYBVRLI
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:11:08 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4865 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbYBVRLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:11:07 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSbQC-000617-00; Fri, 22 Feb 2008 17:10:52 +0000
Content-Disposition: inline
In-Reply-To: <8763whkmxf.fsf@wine.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74735>

On 2008-02-22 16:53:16 +0100, Alexandre Julliard wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > I have a bunch of directories in my tree with only ignored files
> > in them. They used to not show up at all, but now they do.
>
> It probably needs something like this:

That fixed the problem. Thanks!

> Signed-off-by: Alexandre Julliard <julliard@winehq.org>

Tested-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
