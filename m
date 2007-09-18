From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Drop UTF-8 characters in manual pages
Date: Tue, 18 Sep 2007 02:15:35 -0700
Message-ID: <7vd4wgwczs.fsf@gitster.siamese.dyndns.org>
References: <11901003792475-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 11:16:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXZBZ-0008CL-A5
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 11:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbXIRJPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 05:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbXIRJPs
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 05:15:48 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:51452 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbXIRJPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 05:15:47 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B8611373EC;
	Tue, 18 Sep 2007 05:15:58 -0400 (EDT)
In-Reply-To: <11901003792475-git-send-email-mh@glandium.org> (Mike Hommey's
	message of "Tue, 18 Sep 2007 09:26:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58560>

Mike Hommey <mh@glandium.org> writes:

> The default character encoding for english manual pages is ISO8859-1,

On which distro?

> so
> UTF-8 characters are just displayed as their sequence of bytes, which is
> not very appealing.

Perhaps not.  I cannot decide what to do with
Documentation/git-pack-redundant.txt, though.
