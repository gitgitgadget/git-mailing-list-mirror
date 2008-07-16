From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename ".dotest/" to ".git/rebase" and ".dotest-merge"
 to "rebase-merge"
Date: Tue, 15 Jul 2008 18:19:34 -0700
Message-ID: <7vzloiy6ah.fsf@gitster.siamese.dyndns.org>
References: <73fd69b50807151408i6a916da6p7b89fe81e65fc717@mail.gmail.com>
 <20080715212211.GL6244@leksak.fem-net> <487D1B3D.70500@lsrfire.ath.cx>
 <alpine.DEB.1.00.0807160245440.2841@eeepc-johanness>
 <7v4p6qzla3.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Stephan Beyer <s-beyer@gmx.net>,
	Joe Fiorini <joe@faithfulgeek.org>, git@vger.kernel.org,
	Jari Aalto <jari.aalto@cante.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 03:20:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIvhF-0007EV-UO
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 03:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbYGPBTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 21:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753611AbYGPBTr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 21:19:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbYGPBTr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 21:19:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EE23E2AA4A;
	Tue, 15 Jul 2008 21:19:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 34A912AA39; Tue, 15 Jul 2008 21:19:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807160315020.2841@eeepc-johanness> (Johannes
 Schindelin's message of "Wed, 16 Jul 2008 03:15:42 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 46C241EA-52D5-11DD-9909-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88623>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, you can name it as you want.  But I thought that the name 
> "rebase" applies as well: the patches are rebased from somewhere else...

Somewhere else being my mailbox or gmane newsgroup?

The patch does not apply to my master anyway, sigh...
