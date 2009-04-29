From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/9] Show "Pushing <patch>...done" when pushing a patch
Date: Wed, 29 Apr 2009 08:04:48 +0200
Message-ID: <20090429060448.GA18483@diana.vm.bytemark.co.uk>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com> <20090428150940.27261.65680.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 08:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz2vo-0001tQ-Az
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 08:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbZD2GEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 02:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694AbZD2GEx
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 02:04:53 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:44786 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbZD2GEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 02:04:52 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lz2uW-0004oR-00; Wed, 29 Apr 2009 07:04:48 +0100
Content-Disposition: inline
In-Reply-To: <20090428150940.27261.65680.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117848>

On 2009-04-28 16:09:40 +0100, Catalin Marinas wrote:

> My main reason is for the automatic invocation of the interactive
> merge when I don't know what patch I have to deal with. The other
> reasons is for people working over slow filesystems (NFS) where a
> three-way merging may take a significant amount of time.

I don't see any problems with this.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
