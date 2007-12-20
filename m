From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Only filter "#" comments from commits if the editor is used
Date: Thu, 20 Dec 2007 15:39:37 -0800
Message-ID: <7vtzmdlyva.fsf@gitster.siamese.dyndns.org>
References: <20071220211835.GA3052@steel.home>
	<alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
	<20071220233324.GB3052@steel.home> <20071220233539.GC3052@steel.home>
	<20071220233714.GD3052@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Uzw-0006z3-4y
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbXLTXjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbXLTXjx
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:39:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbXLTXjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:39:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 984943251;
	Thu, 20 Dec 2007 18:39:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 29929324F;
	Thu, 20 Dec 2007 18:39:44 -0500 (EST)
In-Reply-To: <20071220233714.GD3052@steel.home> (Alex Riesen's message of
	"Fri, 21 Dec 2007 00:37:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69025>

Thanks.
