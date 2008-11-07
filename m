From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [minor usability suggestion] git rebase <upstream> --onto
 <newbase> ?
Date: Fri, 07 Nov 2008 13:06:46 -0800
Message-ID: <7vy6zvfdp5.fsf@gitster.siamese.dyndns.org>
References: <20081107092035.GA1339@elte.hu>
 <7vej1ngztd.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0811071504110.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Nov 07 22:08:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyYZ7-0004A3-Sp
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 22:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbYKGVHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 16:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbYKGVHK
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 16:07:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbYKGVHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 16:07:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ABB707A9E3;
	Fri,  7 Nov 2008 16:07:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6B9387A9D4; Fri,
  7 Nov 2008 16:06:52 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0811071504110.19665@iabervon.org> (Daniel
 Barkalow's message of "Fri, 7 Nov 2008 15:10:32 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 093A660A-AD10-11DD-81E6-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100332>

Daniel Barkalow <barkalow@iabervon.org> writes:

> "git log origin/master -p" works, though.

That's an accident.  Do not rely on it.
