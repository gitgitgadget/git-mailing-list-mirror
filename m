From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH 10/14] http: use hostname in credential description
Date: Fri, 19 Aug 2011 07:01:21 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87d3g1k3u6.fsf@lifelogs.com>
References: <20110718074642.GA11678@sigill.intra.peff.net>
	<20110718075232.GJ12341@sigill.intra.peff.net>
	<7vr55k4mxn.fsf@alter.siamese.dyndns.org>
	<20110722204749.GC11922@sigill.intra.peff.net>
	<7vbowmx9da.fsf@alter.siamese.dyndns.org>
	<20110722221337.GA15753@sigill.intra.peff.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 14:01:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuNlf-0002Gd-4i
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 14:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab1HSMBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 08:01:38 -0400
Received: from lo.gmane.org ([80.91.229.12]:55964 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab1HSMBh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 08:01:37 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QuNlX-0002Da-UE
	for git@vger.kernel.org; Fri, 19 Aug 2011 14:01:35 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:01:35 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 14:01:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:qsAwsf9GfQXzNv41gSMhFAhwAjY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179695>

I see some info in "What's Cooking" about this patch but it's unclear to
me whether the hostname issue (where it's hard to have multiple
identities on a single server, which I think is all right) is blocking
the inclusion of the patch into the next release, or if it will be
included eventually if no one complains about that issue, or something
else...

Thanks
Ted
