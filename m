From: Mike Hommey <mh@glandium.org>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 08:25:08 +0200
Organization: glandium.org
Message-ID: <20070827062508.GA9002@glandium.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org> <20070827014056.GB7422@mediacenter.austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 08:27:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPY3x-0007xp-Ih
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 08:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbXH0G0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbXH0G0d
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 02:26:33 -0400
Received: from vawad.err.no ([85.19.200.177]:45562 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbXH0G0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 02:26:33 -0400
Received: from aputeaux-153-1-29-74.w82-124.abo.wanadoo.fr ([82.124.191.74] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IPY3I-0007Iw-8R; Mon, 27 Aug 2007 08:26:21 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IPY28-0002MT-52; Mon, 27 Aug 2007 08:25:08 +0200
Content-Disposition: inline
In-Reply-To: <20070827014056.GB7422@mediacenter.austin.rr.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56767>

On Sun, Aug 26, 2007 at 08:40:56PM -0500, Shawn Bohrer <shawn.bohrer@gmail.com> wrote:
> So if I understand you correctly people in the git world are simply more
> used to typing two dots (instead of three) so that is why the two dot
> notation shows the more common use case (show me the difference between
> the tip of the master branch and the tip of the topic branch).
> 
> I must admit that for me, a new git user, it would be much more
> intuitive if all git commands used the same syntax for specifying
> revisions.  After all every other git command that I have used so far
> uses the opposite syntax as git-diff.  This includes git-log,
> git-format-patch, gitk, git-rev-list, and git-rev-parse.

Similar experience here. It is even more a problem for newcomers when
you consider it isn't documented in either git-rev-parse or git-diff
manual pages.

Mike
