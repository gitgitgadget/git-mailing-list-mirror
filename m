From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-send-email getting filtered as spam by vger.kernel.org
Date: Thu, 21 Feb 2008 14:05:02 -0800
Message-ID: <7v4pc2t181.fsf@gitster.siamese.dyndns.org>
References: <200802210429.58353.lenb@kernel.org>
 <200802210721.29188.lenb@kernel.org>
 <20080221205104.GA14247@informatik.uni-freiburg.de>
 <7vejb6t3kk.fsf@gitster.siamese.dyndns.org>
 <76718490802211341o1ddc36bbne4e6d551712e7cd0@mail.gmail.com>
 <20080221214959.GA4338@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, Len Brown <lenb@kernel.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJYG-0000Z1-Mn
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbYBUWFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756187AbYBUWFY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:05:24 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbYBUWFX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 17:05:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A96C2D87;
	Thu, 21 Feb 2008 17:05:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2FA392D81; Thu, 21 Feb 2008 17:05:10 -0500 (EST)
In-Reply-To: <20080221214959.GA4338@glandium.org> (Mike Hommey's message of
 "Thu, 21 Feb 2008 22:49:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74669>

Mike Hommey <mh@glandium.org> writes:

> And reminds me something ;)
> http://kerneltrap.org/mailarchive/git/2007/12/11/488177

Although I admit I try to be less picky about what I am not a
heavy user of, I do not want to be deliberately sloppy by saying
"if ($var)" in Perl when $var is an end-user string (i.e. could
be "0").

Yes, it is unlikely the user mistypes "0" when asked for a
message Id, but it is just a matter of principle...
 
