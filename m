From: Pete Wyckoff <pw@padd.com>
Subject: Re: What's cooking in git.git (Aug 2013, #03; Tue, 13)
Date: Sun, 18 Aug 2013 11:05:23 -0400
Message-ID: <20130818150523.GA13506@padd.com>
References: <7vvc39utxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kazuki saitoh <ksaitoh560@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 17:05:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB4Xu-00074j-8O
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 17:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534Ab3HRPF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 11:05:28 -0400
Received: from honk.padd.com ([74.3.171.149]:39944 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529Ab3HRPF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 11:05:27 -0400
Received: from arf.padd.com (unknown [50.105.10.190])
	by honk.padd.com (Postfix) with ESMTPSA id C0DD75B1F;
	Sun, 18 Aug 2013 08:05:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id DD3E426345; Sun, 18 Aug 2013 11:05:23 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vvc39utxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232479>

gitster@pobox.com wrote on Tue, 13 Aug 2013 15:06 -0700:
> * ks/p4-view-spec (2013-08-11) 3 commits
>  - WAITING FOR ACK
>  - git p4: implement view spec wildcards with "p4 where"
>  - git p4 test: sanitize P4CHARSET
> 
>  Waiting for an ack.

I'm still running perf tests on the 3-patch version.  It
looks good.  You should expect a reroll of the 2nd and 3rd
commits, combining them into one patch.

Thanks for tracking these.

		-- Pete
