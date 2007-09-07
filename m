From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] Eradicate yet-another-buffer implementation in  buitin-rerere.c
Date: Fri, 07 Sep 2007 01:03:28 -0700
Message-ID: <7v642m7vhr.fsf@gitster.siamese.dyndns.org>
References: <20070902224213.GB431@artemis.corp>
	<11890776114037-git-send-email-madcoder@debian.org>
	<118907761140-git-send-email-madcoder@debian.org>
	<11890776111843-git-send-email-madcoder@debian.org>
	<11890776112292-git-send-email-madcoder@debian.org>
	<11890776111670-git-send-email-madcoder@debian.org>
	<11890776112309-git-send-email-madcoder@debian.org>
	<11890776112641-git-send-email-madcoder@debian.org>
	<Pine.LNX.4.64.0709061504521.28586@racer.site>
	<20070906171734.GG8451@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 07 10:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITYoX-0006U6-5S
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 10:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbXIGIDd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 04:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXIGIDd
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 04:03:33 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49779 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964961AbXIGID3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 04:03:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070907080328.IQCN11280.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 7 Sep 2007 04:03:28 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id lL3U1X00C1gtr5g0000000; Fri, 07 Sep 2007 04:03:29 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pierre Habouzit <madcoder@debian.org> writes:

>   crap, and I did that in the 5th patch as well. well, I'll maybe send
> privately a "fixed" version of the patch to junio then, to avoid
> flooding the list with spacing issues.

Heh, no need.  I can fix them up locally here.

For me personally, your use of Mail-Followup-To: header is very
much more irritating.  When I want to talk to you, I want my MUA
to put YOUR name on To: header, not Johannes.  I consider it
rude and selfish to use M-F-T to avoid getting duplicates from a
mailing list you subscribe to.

I have said this often enough in the past, and have been trying
not to say this unless necessary.  It is sad and happy at the
same time that I still occasionary need to bring this up.

Sad because I have to get irritated enough before I say this,
and happy because it means I found another person who is worth
communicating with and expect to communicate again with on the
list.

Please, don't.
