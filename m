From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange code in diff-delta.c
Date: Thu, 23 Aug 2007 00:06:26 -0700
Message-ID: <7vk5rmvifh.fsf@gitster.siamese.dyndns.org>
References: <85k5rnjcbu.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708222126590.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO6m5-0000T3-8g
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbXHWHGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 03:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754782AbXHWHGe
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:06:34 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:57506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbXHWHGe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 03:06:34 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 414DE122DC8;
	Thu, 23 Aug 2007 03:06:51 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0708222126590.16727@xanadu.home> (Nicolas
	Pitre's message of "Wed, 22 Aug 2007 21:45:34 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56464>

Thanks, both.
