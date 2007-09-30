From: Junio C Hamano <gitster@pobox.com>
Subject: Re: suggestion for git stash
Date: Sun, 30 Sep 2007 12:59:54 -0700
Message-ID: <7vfy0vhqkl.fsf@gitster.siamese.dyndns.org>
References: <200709302050.41273.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:00:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic4xT-0007f2-NZ
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbXI3UAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbXI3T77
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 15:59:59 -0400
Received: from rune.pobox.com ([208.210.124.79]:60055 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbXI3T77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 15:59:59 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C552F13F04C;
	Sun, 30 Sep 2007 16:00:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 59B6C13F04B;
	Sun, 30 Sep 2007 16:00:18 -0400 (EDT)
In-Reply-To: <200709302050.41273.bruno@clisp.org> (Bruno Haible's message of
	"Sun, 30 Sep 2007 20:50:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59552>

Isn't "stash apply --index" what you talk about?
