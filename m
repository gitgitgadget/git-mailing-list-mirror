From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Fix "stg branch --delete" on a nonexistent branch
Date: Thu, 14 Feb 2008 01:06:16 +0100
Message-ID: <20080214000616.GB10335@diana.vm.bytemark.co.uk>
References: <87r6fgjwoi.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Toby Allsopp <Toby.Allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Thu Feb 14 01:07:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPRdA-0006t1-IW
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 01:07:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599AbYBNAGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 19:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758645AbYBNAGi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 19:06:38 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2266 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754979AbYBNAGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 19:06:37 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JPRcG-0003Ei-00; Thu, 14 Feb 2008 00:06:16 +0000
Content-Disposition: inline
In-Reply-To: <87r6fgjwoi.fsf@nav-akl-pcn-343.mitacad.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73829>

On 2008-02-14 11:25:29 +1300, Toby Allsopp wrote:

>  stgit/stack.py           |    2 +-
>  t/t1005-branch-delete.sh |    4 ++++
>  2 files changed, 5 insertions(+), 1 deletions(-)

Thanks -- and with a test case! I'll push this out on

  git://repo.or.cz/stgit/kha.git safe

later tonight.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
