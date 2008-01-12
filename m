From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document some default values in config.txt
Date: Fri, 11 Jan 2008 16:06:17 -0800
Message-ID: <7vmyrb29hi.fsf@gitster.siamese.dyndns.org>
References: <200801112211.13816.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 01:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDTto-0006mM-Gd
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 01:06:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761439AbYALAG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 19:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761970AbYALAG2
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 19:06:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761082AbYALAG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 19:06:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 927542DAE;
	Fri, 11 Jan 2008 19:06:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 32DB12DAD;
	Fri, 11 Jan 2008 19:06:24 -0500 (EST)
In-Reply-To: <200801112211.13816.barra_cuda@katamail.com> (Michele Ballabio's
	message of "Fri, 11 Jan 2008 22:11:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70228>

I am not a very big fan of describing the default values, but I
would grudgingly agree they should be mentioned somewhere.

I dropped all the "which in turn defaults to" as they will
invite maintenance nightmare in the future, though.

Thanks.
