From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: update description of shell aliases
Date: Wed, 01 Jul 2009 11:21:07 -0700
Message-ID: <7v7hysl0x8.fsf@alter.siamese.dyndns.org>
References: <2e24e5b90907010900r23ddc8dfl67dee569b508a4b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:21:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM4Qp-0003QF-2v
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 20:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbZGASVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 14:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbZGASVG
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 14:21:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51308 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753349AbZGASVF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 14:21:05 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701182107.DIXB20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Wed, 1 Jul 2009 14:21:07 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id AiM71c00K4aMwMQ04iM7dk; Wed, 01 Jul 2009 14:21:07 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0lJx_3C6LVcA:10 a=pGLkceISAAAA:8
 a=YkYRznjJmrKuq3Xti8EA:9 a=o1vqAdxsCFwB4lDYtlskHY1906QA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <2e24e5b90907010900r23ddc8dfl67dee569b508a4b7@mail.gmail.com> (Sitaram Chamarty's message of "Wed\, 1 Jul 2009 21\:30\:31 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122589>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> Aliases that invoke shell commands start from the top-level directory,
> but this was not documented.

Could you please also think if it is worth mentioning what happens when
you do not even have a top-level directory?  I.e. in a bare repository.
