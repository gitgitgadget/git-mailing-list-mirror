From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 09:10:32 -0700
Message-ID: <7v8wkqbfnr.fsf@alter.siamese.dyndns.org>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
	<20090507072326.GA13123@vidovic>
	<7veiv0cvdt.fsf@alter.siamese.dyndns.org>
	<20090508042814.GA30031@vidovic>
	<94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>
	<20090514160609.GA12910@vidovic>
	<7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
	<20090521041529.GD8091@sigill.intra.peff.net>
	<94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
	<7vvdnubl1x.fsf@alter.siamese.dyndns.org>
	<94a0d4530905210900xa464f75se2bd2bf3d8103b10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:10:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Aqs-0006nh-68
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 18:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999AbZEUQKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 12:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbZEUQKd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 12:10:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:33617 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbZEUQKc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 12:10:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521161033.JVNZ25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 May 2009 12:10:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id uGAY1b00f4aMwMQ03GAYuu; Thu, 21 May 2009 12:10:33 -0400
X-Authority-Analysis: v=1.0 c=1 a=YDhzBoFtm8wA:10 a=AYFEWzs_8uQA:10
 a=pGLkceISAAAA:8 a=sAk6AhOgCwPo8zkhJQIA:9 a=p4-Kw50ix8sRWiIMMTgLmp_n-mEA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <94a0d4530905210900xa464f75se2bd2bf3d8103b10@mail.gmail.com> (Felipe Contreras's message of "Thu\, 21 May 2009 19\:00\:17 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119696>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The "guidelines" (not rules) I followed are a bit hard to explain,
> I'll try to do that, but in the meantime would you deny that the patch
> actually makes things a bit more consistent?

Well, until you spell out what your rules are to decide how things should
be marked up (e.g "command name in prose should be spelled inside sq pair,
like 'git frotz'"), I assert that I cannot even judge if the result of the
patch is consistent with them.  I can only say "wooo, most of the branch
names look green" or something like that, but that kind of comment on the
consistency is as useful to you as "ahh, everything is spelled in American
spellings", iow, not much, isn't it?

Getting everybody agree to the rules is a different matter, but that
happens only after everybody knows what the rules are.
