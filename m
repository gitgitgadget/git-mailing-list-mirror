From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to hide a git repository?
Date: Tue, 25 Nov 2008 13:03:06 -0800
Message-ID: <7vprkjjz79.fsf@gitster.siamese.dyndns.org>
References: <900638.56188.qm@web37904.mail.mud.yahoo.com>
 <alpine.LNX.1.00.0811251327480.19665@iabervon.org>
 <200811252001.37259.thomas@koch.ro> <m3skpfk1mp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Koch <thomas@koch.ro>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gary Yang <garyyang6@yahoo.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 22:06:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5564-0001Aq-V4
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 22:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbYKYVEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 16:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbYKYVEF
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 16:04:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33437 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbYKYVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 16:04:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 539AA8107C;
	Tue, 25 Nov 2008 16:03:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 174398106A; Tue,
 25 Nov 2008 16:03:08 -0500 (EST)
In-Reply-To: <m3skpfk1mp.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 25 Nov 2008 12:10:43 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 933377CA-BB34-11DD-B2F4-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101682>

Jakub Narebski <jnareb@gmail.com> writes:

> If you have something more fancy, check out newest gitweb and take a
> look at gitweb/INSTALL: you can now, thanks to commit dd7f5f1 by
> Alexander Gavrilov, see
>   http://permalink.gmane.org/gmane.comp.version-control.git/99962

Somehow I had an impression that you weren't enthused about that patch.
