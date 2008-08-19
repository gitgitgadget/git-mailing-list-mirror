From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 11:18:05 -0700
Message-ID: <7vzln8c1ia.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
 <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181839390.19665@iabervon.org>
 <7vy72tit90.fsf@gitster.siamese.dyndns.org>
 <m3od3ps02b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:19:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVVna-0001C4-1C
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbYHSSSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbYHSSSO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:18:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYHSSSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:18:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 320EC53F5A;
	Tue, 19 Aug 2008 14:18:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4E03A53F59; Tue, 19 Aug 2008 14:18:08 -0400 (EDT)
In-Reply-To: <m3od3ps02b.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 19 Aug 2008 04:42:42 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2EF46EB0-6E1B-11DD-9A00-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92892>

Jakub Narebski <jnareb@gmail.com> writes:

> BTW. I wonder why in above patch, which I guess is result of running
> git-format-patch and should be between TWO TREES, doesn't use standard
> 'a/' and 'b/' (git-show should also use standard, default prefixes).

You apparently did not read the other messages in the thread (hint: look
for places where I describe what I often do, and pay attention to the
keyword "pretends to be a format-patch output").
