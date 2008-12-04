From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Print conflict details with the new infrastructure (bug #11181)
Date: Thu, 4 Dec 2008 10:30:11 +0100
Message-ID: <20081204093011.GA25060@diana.vm.bytemark.co.uk>
References: <20081203213813.9924.62751.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 10:31:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8AYj-0003Mv-1Z
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 10:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYLDJaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Dec 2008 04:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753801AbYLDJaV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 04:30:21 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2931 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbYLDJaU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 04:30:20 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L8AXF-0006Yd-00; Thu, 04 Dec 2008 09:30:13 +0000
Content-Disposition: inline
In-Reply-To: <20081203213813.9924.62751.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102331>

On 2008-12-03 21:38:13 +0000, Catalin Marinas wrote:

> The patch modifies the IndexAndWorkTree.merge() function to display
> pass the conflict information (files) when raising an exception. The
> logic is similar to the one in the old infrastructure.

Looks good. Thanks.

> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
