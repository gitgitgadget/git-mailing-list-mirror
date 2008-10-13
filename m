From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce core.keepHardLinks
Date: Mon, 13 Oct 2008 07:01:43 -0700
Message-ID: <7vskr0bnlk.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810111344241.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <20081012183855.GA5255@spearce.org>
 <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 13 16:03:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpO0o-0004m0-CP
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 16:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYJMOBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 10:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752780AbYJMOBy
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 10:01:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYJMOBy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 10:01:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E1E86E9BE;
	Mon, 13 Oct 2008 10:01:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AD9C36E9BD; Mon, 13 Oct 2008 10:01:46 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810131057150.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 13 Oct 2008 10:58:01 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C6E7520-992F-11DD-B4DF-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98112>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I cannot fathom why a user wants this much rope to hang themselves 
>> with...
>
> The question is not so much why anyone want to do this, but _if_.

Sorry, I think the question should be _why_.

You can gain a sympathetic "Ah, that is sensible, and 'this much rope to
hang themselves with' comment was unwarranted" only by answering that
question.
