From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] asciidoc: add minor workaround to add an empty line
 after code blocks
Date: Sat, 01 Nov 2008 15:48:33 -0700
Message-ID: <7v7i7n3vwe.fsf@gitster.siamese.dyndns.org>
References: <87skqfus7v.fsf@iki.fi>
 <2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
 <87od13ujm4.fsf@iki.fi> <20081030104503.GA17131@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sat Nov 01 23:50:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwPIA-0008CF-JM
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYKAWst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYKAWst
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:48:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59326 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYKAWss (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:48:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C94FD77AC9;
	Sat,  1 Nov 2008 18:48:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 25B8D77AC7; Sat,  1 Nov 2008 18:48:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3EB4A8A2-A867-11DD-AECB-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99785>

Thanks; I do not have an environment with docbook-xsl-172 handy, so I'll
just take your word and apply it to 'maint'.
