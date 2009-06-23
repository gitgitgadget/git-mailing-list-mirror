From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-mailsplit and TortoiseGit bugs
Date: Mon, 22 Jun 2009 21:41:38 -0700
Message-ID: <7vskhra7el.fsf@alter.siamese.dyndns.org>
References: <5b31733c0906221053k4b2659bev1da861b8e997eb5f@mail.gmail.com>
	<20090622202939.GA11912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Filip Navara <filip.navara@gmail.com>, git@vger.kernel.org,
	tortoisegit-dev@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 23 06:41:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIxpR-0003eX-E2
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 06:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbZFWElk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 00:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbZFWElj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 00:41:39 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47030 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZFWElj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 00:41:39 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090623044142.OACJ25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Tue, 23 Jun 2009 00:41:42 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 7Ghh1c0064aMwMQ04GhhWt; Tue, 23 Jun 2009 00:41:41 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=03K4rifJ6HMA:10 a=PKzvZo6CAAAA:8
 a=bs4qDBMud-q40OeD5dwA:9 a=p0iOrYP5SkoT3zFc3puV2EfFIPEA:4 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122071>

Jeff King <peff@peff.net> writes:

> mailinfo: accept useless non-multipart boundary attributes

Is this "accept"? Or do you mean "ignore"?
