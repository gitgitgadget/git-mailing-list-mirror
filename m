From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: patch import with fuzz
Date: Fri, 25 Jan 2008 10:38:49 +0100
Message-ID: <20080125093849.GA6591@diana.vm.bytemark.co.uk>
References: <9e4733910801241901t230898d2t90ce2a14152e1af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIL25-0004cI-NS
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 10:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbYAYJi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 04:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbYAYJi4
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 04:38:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3155 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbYAYJiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 04:38:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIL1N-0001jR-00; Fri, 25 Jan 2008 09:38:49 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801241901t230898d2t90ce2a14152e1af1@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71692>

On 2008-01-24 22:01:37 -0500, Jon Smirl wrote:

> Is there a way to allow a patch import with fuzz?

Not currently. And it appears that git doesn't have this power either
-- and I guess if it's useful in StGit, its useful in git too, so I'm
not too keen on making StGit call "patch" or some such instead of
teaching git to do this. Then again, it'd be useful, and I doubt I'd
get around to teaching fuzz to git-apply any time soon ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
