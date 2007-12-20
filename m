From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Only filter "#" comments from commits if the editor is used
Date: Thu, 20 Dec 2007 15:43:14 -0800
Message-ID: <7vprx1lyp9.fsf@gitster.siamese.dyndns.org>
References: <20071220211835.GA3052@steel.home>
	<alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org>
	<20071220233324.GB3052@steel.home> <20071220233539.GC3052@steel.home>
	<20071220233714.GD3052@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 00:43:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5V3O-0008Fj-4e
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 00:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbXLTXn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 18:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755038AbXLTXn0
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 18:43:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924AbXLTXnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 18:43:25 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5516C3296;
	Thu, 20 Dec 2007 18:43:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7E593294;
	Thu, 20 Dec 2007 18:43:20 -0500 (EST)
In-Reply-To: <20071220233714.GD3052@steel.home> (Alex Riesen's message of
	"Fri, 21 Dec 2007 00:37:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69026>

I said thanks a bit too early.  That is on top of verbatim, which I have
doubts about putting in 1.5.4.  I on the other hand think Linus's is a
pure bugfix.

Will tweak and apply, thanks.
