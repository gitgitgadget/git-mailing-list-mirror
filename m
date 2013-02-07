From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Thu, 07 Feb 2013 09:30:16 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87wqukci2v.fsf@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v6226pdb7.fsf@alter.siamese.dyndns.org>
	<vpqa9rhaml6.fsf@grenoble-inp.fr> <876225o5mj.fsf@lifelogs.com>
	<vpqmwvhxyuj.fsf@grenoble-inp.fr> <87sj59mo2y.fsf@lifelogs.com>
	<20130206215724.GA27507@sigill.intra.peff.net>
	<8738x9ghpu.fsf@lifelogs.com> <vpq4nhowqgk.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Michal Nazarewicz <mpn@google.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>,
	Michal Nazarewicz <mina86@mina86.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Feb 07 15:30:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3SUt-0001O0-H2
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 15:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758667Ab3BGOaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 09:30:19 -0500
Received: from z.lifelogs.com ([173.255.230.239]:34822 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758616Ab3BGOaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 09:30:18 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id CB751DE0E7;
	Thu,  7 Feb 2013 14:30:17 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <vpq4nhowqgk.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Thu, 07 Feb 2013 08:08:59 +0100")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215698>

On Thu, 07 Feb 2013 08:08:59 +0100 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 

MM> Plus, read/write has already been used for a while in the C API, so I'd
MM> rather keep the same names for the Perl equivalent.

That makes perfect sense.

Ted
