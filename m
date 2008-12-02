From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Do not append a new line to the backwards compat files (bug #12656)
Date: Tue, 2 Dec 2008 16:39:16 +0100
Message-ID: <20081202153916.GA19967@diana.vm.bytemark.co.uk>
References: <20081202143839.24221.90893.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 16:41:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XMf-0007CL-IV
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 16:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYLBPjW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2008 10:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754964AbYLBPjV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 10:39:21 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2938 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbYLBPjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 10:39:20 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L7XLI-0006DX-00; Tue, 02 Dec 2008 15:39:16 +0000
Content-Disposition: inline
In-Reply-To: <20081202143839.24221.90893.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102146>

On 2008-12-02 14:38:39 +0000, Catalin Marinas wrote:

> Since the multiline argument wasn't passed to the
> utils.write_string() function when writing the compatibility
> description file from the new infrastructure, any older command like
> push would have committed these new lines.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

Thanks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
