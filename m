From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 4/4] Use a default "hidden" argument in StackTransaction.reorder_patches
Date: Tue, 17 Mar 2009 17:38:08 +0100
Message-ID: <20090317163808.GE10001@diana.vm.bytemark.co.uk>
References: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com> <20090317110910.27748.80312.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:39:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjcKK-0004lI-Ba
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbZCQQiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 12:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbZCQQiO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:38:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:56715 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754608AbZCQQiL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:38:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LjcIq-0003ht-00; Tue, 17 Mar 2009 16:38:08 +0000
Content-Disposition: inline
In-Reply-To: <20090317110910.27748.80312.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113500>

On 2009-03-17 11:09:10 +0000, Catalin Marinas wrote:

> This argument is rarely used so adding a default value simplifies
> the calling code.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
