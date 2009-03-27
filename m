From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 0/8] Documentation: XSLT/asciidoc.conf cleanup; tty
 literals
Date: Fri, 27 Mar 2009 01:43:57 -0500
Message-ID: <1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:46:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5pn-0007vH-7k
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbZC0Gox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753696AbZC0Gow
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:44:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbZC0Gov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:44:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 546DB934F;
	Fri, 27 Mar 2009 02:44:49 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 BBA17934E; Fri, 27 Mar 2009 02:44:46 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
X-Pobox-Relay-ID: C49952F6-1A9A-11DE-BDDE-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114853>

"v1" of this series can be found here: <http://thread.gmane.org/gmane.comp.version-control.git/114417>.

Change since "v1":

  1/8: No content change from "v1". This time -C -M was used to
       show copy/rename of callouts.xsl (thanks to Peff for
       pointing to diff.renames config option).

  2/8: Use <xsl:import> instead of xmlto command line to reuse
       manpage-base.xsl. In commit message, move discussion of
       --stringparm to 8/8.

  8/8: No content change from "v1" (though context is changed due
       to content change in 2/8). In commit message, add some of
       --stringparm discussion from "v1" 2/8.

-- 
Chris
