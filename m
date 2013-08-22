From: Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: Git access to Bzr repository fails for enwc
Date: Wed, 21 Aug 2013 21:18:20 -0400
Message-ID: <jwva9kamsl6.fsf-monnier+emacs@gnu.org>
References: <jwvbo4ygbo8.fsf-monnier+emacs@gnu.org>
	<CAMP44s0zMbgt8snc=HkDqYHCWGZ3b4_oFZs64K48RjoXVR+1Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 03:18:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCJXg-0005WG-1j
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 03:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab3HVBSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 21:18:24 -0400
Received: from ironport2-out.teksavvy.com ([206.248.154.182]:39355 "EHLO
	ironport2-out.teksavvy.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120Ab3HVBSX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Aug 2013 21:18:23 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EABK/CFHO+LNT/2dsb2JhbABEvw4Xc4IeAQEEAScvIwULCzQSFBgNJIgeBgzBHQSRCgOkeoFegxM
X-IPAS-Result: Av4EABK/CFHO+LNT/2dsb2JhbABEvw4Xc4IeAQEEAScvIwULCzQSFBgNJIgeBgzBHQSRCgOkeoFegxM
X-IronPort-AV: E=Sophos;i="4.84,565,1355115600"; 
   d="scan'208";a="22891230"
Received: from 206-248-179-83.dsl.teksavvy.com (HELO fmsmemgm.homelinux.net) ([206.248.179.83])
  by ironport2-out.teksavvy.com with ESMTP/TLS/ADH-AES256-SHA; 21 Aug 2013 21:18:14 -0400
Received: by fmsmemgm.homelinux.net (Postfix, from userid 20848)
	id 5BA47AE1E0; Wed, 21 Aug 2013 21:18:20 -0400 (EDT)
In-Reply-To: <CAMP44s0zMbgt8snc=HkDqYHCWGZ3b4_oFZs64K48RjoXVR+1Tw@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 21 Aug 2013 15:16:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232758>

>> I've had good success recently with the git->bzr bridge, but the
>> following still fails.  This is on Debian with the git from "unstable".
> Which version are you using?

The one that comes in Debian unstable.

> The latest version works fine here:
> https://github.com/felipec/git/blob/fc/master/git-remote-bzr.py

Indeed, that works, thank you,


        Stefan
