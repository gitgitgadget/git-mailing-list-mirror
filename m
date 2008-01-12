From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Fri, 11 Jan 2008 18:18:34 -0800
Message-ID: <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 03:19:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVxz-0002NZ-Rv
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 03:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbYALCS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 21:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762938AbYALCS4
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 21:18:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbYALCSz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 21:18:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4794B1C8A;
	Fri, 11 Jan 2008 21:18:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8AF91C89;
	Fri, 11 Jan 2008 21:18:50 -0500 (EST)
In-Reply-To: <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	(Mark Levedahl's message of "Fri, 11 Jan 2008 15:52:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70252>

"Mark Levedahl" <mlevedahl@gmail.com> writes:

>> However, it is a bit hard to judge how much of inconvenience it
>> really is in your real life that the current behaviour does not
>> allow you to.
>
> I believe I addressed this in the thread with Dscho.

Thanks.

I have to admit that I happen to agree with Dscho.  I do not see
this helping to solve communication issues very much.
