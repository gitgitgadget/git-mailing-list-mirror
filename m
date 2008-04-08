From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Integration branching
Date: Tue, 08 Apr 2008 11:49:33 -0700
Message-ID: <7vmyo4mbb6.fsf@gitster.siamese.dyndns.org>
References: <b24851260804070602o11b93923m7ce7d79d5f59547b@mail.gmail.com>
 <7vod8lpnpb.fsf@gitster.siamese.dyndns.org>
 <b24851260804071118h4eaadef8i8313c5a4cb26495d@mail.gmail.com>
 <32541b130804071132q24acff6an853730af4fc7273e@mail.gmail.com>
 <b24851260804080656u4c42c31cv3984fa2943d83b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>, git@vger.kernel.org
To: "Kai Hendry" <hendry@aplixcorp.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:50:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjIu0-0006u1-Dq
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 20:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbYDHSty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 14:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYDHSty
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 14:49:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbYDHSty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 14:49:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 327B210BA3;
	Tue,  8 Apr 2008 14:49:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 327C510A0C; Tue,  8 Apr 2008 14:49:43 -0400 (EDT)
In-Reply-To: <b24851260804080656u4c42c31cv3984fa2943d83b8a@mail.gmail.com>
 (Kai Hendry's message of "Tue, 8 Apr 2008 14:56:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79014>

"Kai Hendry" <hendry@aplixcorp.com> writes:

> I need http:// to work as some of the engineers I work with are behind
> a "corporate firewall" that doesn't allow ssh://. Crazy, I know.

It is not "crazy", but simply is "unfortunate".  I am not involved in
http-push at all myself, but I recall there was somebody working on
improving it recently?
