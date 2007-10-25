From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 17:01:07 +0200
Message-ID: <20071025150107.GB31196@diana.vm.bytemark.co.uk>
References: <86oden6z97.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 17:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il4DD-0006f5-9I
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 17:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759821AbXJYPBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2007 11:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759486AbXJYPBN
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 11:01:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4678 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758683AbXJYPBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 11:01:12 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Il4Cp-0008AR-00; Thu, 25 Oct 2007 16:01:07 +0100
Content-Disposition: inline
In-Reply-To: <86oden6z97.fsf@blue.stonehenge.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62324>

On 2007-10-25 07:32:36 -0700, Randal L. Schwartz wrote:

> And when are we gonna get "fast forward only" for git-merge?

I'd like that too. For cases when I know I don't have to do a merge,
and want git to yell at me if I'm mistaken. For example, in a
repository that tracks an upstream so I can build the latest version,
but where I don't normally do any development.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
