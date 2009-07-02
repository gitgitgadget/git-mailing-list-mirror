From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv1bis 1/2] git apply: option to ignore whitespace  differences
Date: Thu, 02 Jul 2009 14:00:19 -0700
Message-ID: <7vws6q3in0.fsf@alter.siamese.dyndns.org>
References: <1246556921-5819-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246556921-5819-2-git-send-email-giuseppe.bilotta@gmail.com>
	<7vvdmb6ium.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907021202ra322425pc64b54953f4f544d@mail.gmail.com>
	<cb7bb73a0907021228q7e9d2791vafead8e0c5b06b79@mail.gmail.com>
	<7vhbxu6f87.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 23:00:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMTON-0003w3-Fa
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 23:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbZGBVAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbZGBVAR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 17:00:17 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61868 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbZGBVAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 17:00:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702210019.XZOZ17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Jul 2009 17:00:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id B90K1c0064aMwMQ0390KqX; Thu, 02 Jul 2009 17:00:19 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=SK8bdSSw-t4A:10 a=pGLkceISAAAA:8
 a=LDQE2W8kyIp08G2s3A0A:9 a=wTajOUcynMbsyIMVDTYrSq4WijYA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0907021333t6f377d61v1c1479c15b72c436@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 2 Jul 2009 22\:33\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122671>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> I do wonder what makes the patch 'unreviewable', since I assume that
> doesn't mean just 'does not include the refactoring I requested'.

Ok, unreviewable may not be the word, and "it is apparent that the patch
has not been well thought through" is the word I would want.

IOW, it really should have been marked as "[RFC/PATCH]".
