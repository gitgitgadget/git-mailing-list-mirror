From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-format-patch: add a new format.cc configuration
 variable
Date: Sat, 26 Apr 2008 17:14:29 -0700
Message-ID: <7vskx8kvbu.fsf@gitster.siamese.dyndns.org>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org>
 <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 27 02:15:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpuYN-0002Du-0f
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 02:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbYD0AOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 20:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753183AbYD0AOi
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 20:14:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbYD0AOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 20:14:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EF6FF338C;
	Sat, 26 Apr 2008 20:14:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6E93E338B; Sat, 26 Apr 2008 20:14:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness> (Johannes
 Schindelin's message of "Sat, 26 Apr 2008 23:31:13 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80400>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I am wary... should this not be specific to send-email?  IOW should 
> format-patch not be left alone?

Yes, it should.
