From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Mon, 18 Feb 2008 15:56:12 -0800
Message-ID: <7v8x1hom3n.fsf@gitster.siamese.dyndns.org>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com>
 <200802152216.42533.jnareb@gmail.com>
 <C8D96592-DD9C-47D3-93AB-3F74719F4D46@wincent.com>
 <200802190032.36712.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 00:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRFr1-000606-2u
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 00:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYBRX4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 18:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbYBRX4Y
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 18:56:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbYBRX4X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 18:56:23 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B013782D;
	Mon, 18 Feb 2008 18:56:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 7A2A27825; Mon, 18 Feb 2008 18:56:15 -0500 (EST)
In-Reply-To: <200802190032.36712.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue, 19 Feb 2008 00:32:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74358>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio, would you consider applying one of those patches? Any of them
> should fix the bug; the second one is less intrusive.

Surely.

By "the second one" do you mean this one?

    Subject: [PATCH] gitweb: Add new option -nohtml to quot_xxx subroutines
    Date: Sun, 17 Feb 2008 18:48:13 +0100
    Message-ID: <20080217174812.30454.86822.stgit@localhost.localdomain>
