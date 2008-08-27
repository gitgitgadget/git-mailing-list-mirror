From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 16:27:49 -0700
Message-ID: <7vd4jukphm.fsf@gitster.siamese.dyndns.org>
References: <20080826164526.GM26610@one.firstfloor.org>
 <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu>
 <20080827195019.GA9962@sigill.intra.peff.net>
 <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu>
 <48B5BC5F.4070209@kernel.org>
 <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@kernel.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Andi Kleen <andi@firstfloor.org>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYURx-0007UB-AK
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbYH0X2K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753857AbYH0X2J
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:28:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYH0X2I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:28:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 68DB26A85C;
	Wed, 27 Aug 2008 19:28:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 897A66A849; Wed, 27 Aug 2008 19:27:51 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com>
 (Steven Rostedt's message of "Wed, 27 Aug 2008 17:19:42 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD483C8E-748F-11DD-91D0-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93983>

Steven Rostedt <rostedt@goodmis.org> writes:

> Yes, they are all a bunch of Nazi git fanatics, that Hitler himself would 
> have used the space version of git. He sent the Jews off to the 
> concentration camps because they insisted on using the dashes.
>
> There, we have a Hitler reference.
>
> CAN WE PLEASE LET THIS THREAD DIE!

Yeah, I second this.

The primary topic has already settled, and we will keep git-foo in libexec
even for built-ins.

This offtopic tangent that shouldn't even have started from the beginning
must die now.  It outlived its usefulness even as a place for people to
vent.
