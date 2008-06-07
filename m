From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 2/5] Create a git.Branch class as ancestor of stack.Stack
Date: Sat, 7 Jun 2008 11:16:28 +0200
Message-ID: <20080607091628.GD32647@diana.vm.bytemark.co.uk>
References: <20080606204322.8805.32313.stgit@localhost.localdomain> <20080606204545.8805.29222.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 11:17:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4uYB-0004hT-UC
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 11:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbYFGJQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 05:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbYFGJQf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 05:16:35 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1846 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884AbYFGJQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 05:16:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K4uXE-0000Ko-00; Sat, 07 Jun 2008 10:16:28 +0100
Content-Disposition: inline
In-Reply-To: <20080606204545.8805.29222.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84190>

On 2008-06-06 21:45:45 +0100, Catalin Marinas wrote:

> This class deals with Git-specific branch commands. The Stack class
> is a direct child of Branch and some of its functionality was moved
> to the new class.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
