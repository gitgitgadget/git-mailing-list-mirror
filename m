From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-read-tree: document -v option.
Date: Mon, 09 Jun 2008 13:06:45 -0700
Message-ID: <7vhcc2gyp6.fsf@gitster.siamese.dyndns.org>
References: <1210896515-5202-1-git-send-email-vmiklos@frugalware.org>
 <20080609154046.GR29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5nfC-00056r-JC
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYFIUG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 16:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753962AbYFIUG6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:06:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbYFIUG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:06:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EDAE1BCD;
	Mon,  9 Jun 2008 16:06:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DAE7F1BC8; Mon,  9 Jun 2008 16:06:52 -0400 (EDT)
In-Reply-To: <20080609154046.GR29404@genesis.frugalware.org> (Miklos Vajna's
 message of "Mon, 9 Jun 2008 17:40:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9BDC9D98-365F-11DD-B7C1-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84416>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Fri, May 16, 2008 at 02:08:35AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> +-v::
>> +        Be verbose.
>> +
>
> Ping? ;-)
>
> I guess this was just lost.

Most likely it was, especially because the signal content of that patch is
next to nil.  "Be verbose" in what sense?
