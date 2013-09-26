From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] Remove ciabot from contrib
Date: Thu, 26 Sep 2013 15:50:52 -0500
Message-ID: <87li2jl32r.fsf@gmail.com>
References: <1380227582-7836-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 26 22:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPIWh-0001V5-Q1
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 22:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab3IZUvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 16:51:04 -0400
Received: from plane.gmane.org ([80.91.229.3]:45135 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab3IZUvC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 16:51:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VPIWb-0001MA-2B
	for git@vger.kernel.org; Thu, 26 Sep 2013 22:51:01 +0200
Received: from nat-128-62-40-141.public.utexas.edu ([128.62.40.141])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 22:51:01 +0200
Received: from keshav.kini by nat-128-62-40-141.public.utexas.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 22:51:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nat-128-62-40-141.public.utexas.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:X0oQRBX0+48F/JZQ0VRj0tf+00Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235435>

Stefan Beller <stefanbeller@googlemail.com> writes:

> According to
> http://thread.gmane.org/gmane.comp.version-control.git/212649
> Eric, the original author of ciabot, doesn't want the ciabot
> no longer be included in git.git, hence the removal of the
> whole directory.

I take it you mean that he doesn't want the ciabot *any* longer be
included in git.git, right? I would rephrase it as follows:

    Eric, the original author of ciabot, no longer wants the ciabot to
    be included in git.git, hence the removal of the whole directory.

    See http://thread.gmane.org/gmane.comp.version-control.git/212649 .

-Keshav
