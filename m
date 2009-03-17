From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 1/4] Add mergetool support to the classic StGit infrastructure
Date: Tue, 17 Mar 2009 16:29:12 +0100
Message-ID: <20090317152912.GB10001@diana.vm.bytemark.co.uk>
References: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com> <20090317110853.27748.70157.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 16:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbFl-0000z8-TA
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 16:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050AbZCQP3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbZCQP3Q
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 11:29:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:49523 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZCQP3P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 11:29:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjbE8-0003IU-00; Tue, 17 Mar 2009 15:29:12 +0000
Content-Disposition: inline
In-Reply-To: <20090317110853.27748.70157.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113481>

On 2009-03-17 11:08:53 +0000, Catalin Marinas wrote:

> Since Git already has a tool for interactively solving conflicts
> which is highly customisable, there is no need to duplicate this
> feature via the i3merge and i2merge configuration options. The
> user-visible change is that now mergetool is invoked rather than the
> previously customised interactive merging tool.
>
> The stgit.keeporig option is no longer available to be more
> consistent with the Git behaviour.

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
