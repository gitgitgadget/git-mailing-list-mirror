From: =?utf-8?Q?Peter_M=C3=BCnster?= <pmlists@free.fr>
Subject: Re: feature request: git svn dommit --preserve-timestamps
Date: Tue, 07 Jun 2016 07:44:26 +0200
Message-ID: <87ziqx5z9h.fsf@free.fr>
References: <87a8iy6s4e.fsf@free.fr> <20160607000902.GA4445@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 07:45:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA9ox-0006C1-UR
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 07:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcFGFo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 01:44:56 -0400
Received: from plane.gmane.org ([80.91.229.3]:56863 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884AbcFGFoz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 01:44:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bA9om-000661-V6
	for git@vger.kernel.org; Tue, 07 Jun 2016 07:44:49 +0200
Received: from arennes-651-1-298-135.w2-12.abo.wanadoo.fr ([2.12.1.135])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 07:44:48 +0200
Received: from pmlists by arennes-651-1-298-135.w2-12.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 07:44:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: arennes-651-1-298-135.w2-12.abo.wanadoo.fr
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.50 (gnu/linux)
Cancel-Lock: sha1:BFnukxBxW1XmqgMP8YJWWu3+GgU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296596>

On Tue, Jun 07 2016, Eric Wong wrote:

> Peter M=C3=BCnster <pmlists@free.fr> wrote:
>> It would be nice, if timestamps could be preserved when rewriting th=
e
>> git-log.
>
> Unfortunately, last I checked (a long time ago!), explicitly
> setting revprops might require SVN administrators to enable the
> feature for the repo.

Not the svn-log, only the git-log.


> It's been a while and I'm not up-to-date with the latest SVN.
> Maybe there's a newer/easier way you could give us details about :)

No, sorry. I don't care about the svn-log.

--=20
           Peter
