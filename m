From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/11] Build in clone
Date: Sat, 08 Mar 2008 21:32:46 -0800
Message-ID: <7v4pbgsbr5.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803081803250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 06:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYEAW-0004ZZ-S8
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 06:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbYCIFcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 00:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYCIFcx
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 00:32:53 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYCIFcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 00:32:52 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BAE52095;
	Sun,  9 Mar 2008 00:32:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 9C3ED2094; Sun,  9 Mar 2008 00:32:48 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0803081803250.19665@iabervon.org> (Daniel
 Barkalow's message of "Sat, 8 Mar 2008 18:03:52 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76635>

Daniel Barkalow <barkalow@iabervon.org> writes:

> (Unrelated note: it might actually be good to use some sort of log
> instead of shortlog in --cover-letter, at least as an option, in order
> to list the contents of the series with the patch numbers and order
> they have)

Certainly, I think that is a good idea.
