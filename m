From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-ls-tree.txt: Add a caveat about
 prefixing pathspec
Date: Sun, 27 Jul 2008 18:26:15 -0700
Message-ID: <7vvdyqx0i0.fsf@gitster.siamese.dyndns.org>
References: <20080720233956.GH10151@machine.or.cz>
 <20080721075618.14163.45309.stgit@localhost>
 <7v1w1nvf7q.fsf@gitster.siamese.dyndns.org>
 <20080721210452.GP10151@machine.or.cz>
 <7vd4l6sqqz.fsf@gitster.siamese.dyndns.org>
 <20080722224759.GJ32184@machine.or.cz> <20080728004604.GF32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 28 03:27:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNHWJ-0008RD-C5
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 03:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbYG1B01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 21:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbYG1B01
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 21:26:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYG1B00 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 21:26:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 57D9B3A132;
	Sun, 27 Jul 2008 21:26:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D7DE73A130; Sun, 27 Jul 2008 21:26:22 -0400 (EDT)
In-Reply-To: <20080728004604.GF32184@machine.or.cz> (Petr Baudis's message of
 "Mon, 28 Jul 2008 02:46:04 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 31C46B60-5C44-11DD-8DCC-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90393>

Petr Baudis <pasky@suse.cz> writes:

>> We may throw a dice or go with your version, I don't care *that* much
>> about this change, I just wouldn't make it personally.
>
> What is the status of this patch? :-) Dropped altogether?

Left behind on the far side of oblivion; I do not offhand recall what this
was about, sorry.
