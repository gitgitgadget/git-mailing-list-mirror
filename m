From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: GSoC intro
Date: Wed, 28 Mar 2012 09:30:49 +0000 (UTC)
Message-ID: <loom.20120328T112337-150@post.gmane.org>
References: <11292500.AVmZFUUvNi@flobuntu> <CAFfmPPPabm_H9f2Zr8eWc7Wxo6UDz-km_Vg8cc-O38XhGCrj7Q@mail.gmail.com> <11105663.xsXc2sBkNH@flobuntu> <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com> <buo8vilf8ox.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 11:31:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCpDj-0004jl-AG
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 11:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab2C1JbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 05:31:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:33136 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932249Ab2C1JbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 05:31:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SCpDX-0004bv-El
	for git@vger.kernel.org; Wed, 28 Mar 2012 11:30:59 +0200
Received: from dhcp249-230.yandex.net ([87.250.249.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:30:59 +0200
Received: from divanorama by dhcp249-230.yandex.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 11:30:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.250.249.230 (Opera/9.80 (X11; Linux x86_64; U; en) Presto/2.10.229 Version/11.61)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194113>

Miles Bader <miles <at> gnu.org> writes:

> git-svn's also pretty annoying to use (e.g.  the way dcommit rebases
> anything you push to svn, which makes juggling local git branches
> problematic; ugh)... :/

There is git svn dcommit --no-rebase to disable the rebase step.
"upstream svn" branch history will still diverge from your local branch though.

> 
> -miles
> 
