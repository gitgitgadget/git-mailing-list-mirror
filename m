From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Fri, 30 May 2008 14:35:13 -0700
Message-ID: <7v8wxriige.fsf@gitster.siamese.dyndns.org>
References: <200805232221.45406.trast@student.ethz.ch>
 <200805291737.53291.trast@student.ethz.ch>
 <20080529185808.GA2140@sigill.intra.peff.net>
 <200805301421.46162.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 30 23:36:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CGt-000880-9J
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbYE3Vfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYE3Vfa
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:35:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082AbYE3Vfa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:35:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C11937A6;
	Fri, 30 May 2008 17:35:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D38BE37A0; Fri, 30 May 2008 17:35:20 -0400 (EDT)
In-Reply-To: <200805301421.46162.trast@student.ethz.ch> (Thomas Rast's
 message of "Fri, 30 May 2008 14:21:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51E2A2E0-2E90-11DD-BA7A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83341>

Thomas Rast <trast@student.ethz.ch> writes:

> Unfortunately git-apply does not seem to have a --dry-run option.

--check?
