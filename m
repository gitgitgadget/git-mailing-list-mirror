From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: config option for diff-opts
Date: Wed, 23 Jan 2008 04:18:29 +0100
Message-ID: <20080123031829.GB25508@diana.vm.bytemark.co.uk>
References: <9e4733910801221904k5f66a231t9cb8330eff3861c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:19:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHW92-0001TP-2K
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 04:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983AbYAWDSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 22:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYAWDSk
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 22:18:40 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3579 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbYAWDSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 22:18:39 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JHW8D-0006jX-00; Wed, 23 Jan 2008 03:18:29 +0000
Content-Disposition: inline
In-Reply-To: <9e4733910801221904k5f66a231t9cb8330eff3861c4@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71505>

On 2008-01-22 22:04:21 -0500, Jon Smirl wrote:

> Could I get a config option added to stgit for diff-opts? So that I
> can always have git diff -M set on renames.

Good idea. I've often needed this myself, without consciously
realizing it -- my bash is set to save an infinite amount of history,
so Ctrl+R always helps me out ...

Will whip up, unless someone beats me to it. It's getting sorta late,
so I won't have time for at least a day or two.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
