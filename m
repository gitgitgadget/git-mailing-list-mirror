From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Commit 140b378d07229e breaks gitk highlighting
Date: Wed, 10 Sep 2008 18:01:12 +0200
Message-ID: <20080910160112.GC26098@diana.vm.bytemark.co.uk>
References: <30e4a070809090531i6c6dd2c8r189e70927b5444c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 17:40:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdRnt-00036n-Ht
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 17:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYIJPjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2008 11:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbYIJPjS
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 11:39:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1868 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbYIJPjR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 11:39:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KdS80-0006pa-00; Wed, 10 Sep 2008 17:01:12 +0100
Content-Disposition: inline
In-Reply-To: <30e4a070809090531i6c6dd2c8r189e70927b5444c9@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95533>

On 2008-09-09 08:31:19 -0400, Mark Levedahl wrote:

> gitk since the above commit ("Teach git diff-tree --stdin to diff
> trees") fails to reliably highlight commits matching a given path
> specification.

Hmmm, not good. Any idea of what git commands gitk actually runs in
your example? Would be nice to be able to diff the output before and
after the change.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
