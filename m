From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: What's cooking in git.git (Aug 2013, #06; Tue, 27)
Date: Wed, 28 Aug 2013 02:05:48 +0200
Message-ID: <20130828000548.GA5238@camk.edu.pl>
References: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 02:06:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VETGx-0000tn-10
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 02:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038Ab3H1AGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 20:06:00 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:51246 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004Ab3H1AGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 20:06:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id E3A6C5F0006;
	Wed, 28 Aug 2013 02:06:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6gyMAvewpHI5; Wed, 28 Aug 2013 02:06:19 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 257FF5F000B;
	Wed, 28 Aug 2013 02:06:19 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id B7CAC4812B; Wed, 28 Aug 2013 02:05:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqsixvaqh5.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233169>

On Tue, Aug 27, 2013 at 12:22:30PM -0700, Junio C Hamano wrote:
> * kk/tests-with-no-perl (2013-08-24) 4 commits
>  - reset test: modernize style
>  - t/t7106-reset-unborn-branch.sh: Add PERL prerequisite
>  - add -i test: use skip_all instead of repeated PERL prerequisite
>  - Make test "using invalid commit with -C" more strict

>  Am I waiting for another reroll?

>From these four commits only the second and last one are from me and I'm
happy with their form as in pu (I see that you have already introduced
your improvement of  "commit --allow-empty" to the last one). Unless
there are some remarks to them.

But I don't know what about Jonathan's commits.

As a matter of fact I have no idea how I even should reroll the topic
that includes commits with mixed authorship.

-- 
  Kacper
