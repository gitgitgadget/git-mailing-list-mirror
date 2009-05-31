From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Remove the resolved command
Date: Sun, 31 May 2009 10:21:41 +0200
Message-ID: <20090531082141.GB17719@diana.vm.bytemark.co.uk>
References: <20090529213013.8908.45041.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 10:21:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAgIf-0006Su-Tl
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 10:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757106AbZEaIVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 May 2009 04:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757073AbZEaIVk
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 04:21:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:44014 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807AbZEaIVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 04:21:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1MAgIX-0004dN-00; Sun, 31 May 2009 09:21:41 +0100
Content-Disposition: inline
In-Reply-To: <20090529213013.8908.45041.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120387>

On 2009-05-29 22:30:13 +0100, Catalin Marinas wrote:

> This command simply duplicates the "git add" or "git mergetool"
> commands for handling conflicts.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
