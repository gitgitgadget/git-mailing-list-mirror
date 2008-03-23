From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 23 Mar 2008 10:37:32 -0700
Message-ID: <7vve3d734z.fsf@gitster.siamese.dyndns.org>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
 <7vwso85qkf.fsf@gitster.siamese.dyndns.org>
 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
 <alpine.OSX.1.00.0803231334210.11994@cougar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdU9Q-0000Fj-7i
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYCWRhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYCWRhu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:37:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYCWRht (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 13:37:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32E1D2BE2;
	Sun, 23 Mar 2008 13:37:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A36BA2BE1; Sun, 23 Mar 2008 13:37:40 -0400 (EDT)
In-Reply-To: <alpine.OSX.1.00.0803231334210.11994@cougar> (Steffen Prohaska's
 message of "Sun, 23 Mar 2008 13:39:59 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77930>

Steffen Prohaska <prohaska@zib.de> writes:

> The merge test passes for me (on hfs+).  The "git mv" test still fails;
> Linus made clear that "git mv" is not yet fixed.

I was actually talking about the case with your patch applied to t0050 on
case sensitive systems.
