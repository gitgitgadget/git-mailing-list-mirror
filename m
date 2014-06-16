From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH] Coding guideline for Error messages
Date: Mon, 16 Jun 2014 13:55:56 +0100
Message-ID: <1402923357-3788-1-git-send-email-philipoakley@iee.org>
Cc: Jeff King <peff@peff.net>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 14:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwWS1-00005B-HH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 14:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbaFPMzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 08:55:49 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:58461 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbaFPMzs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jun 2014 08:55:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkkMAHjonlMCYJ7h/2dsb2JhbABagw0BYgOuGY4Eh0IMgQUXdYRgIxiBAiSIWc9GjnY1hBUErhuDQTw
X-IPAS-Result: AkkMAHjonlMCYJ7h/2dsb2JhbABagw0BYgOuGY4Eh0IMgQUXdYRgIxiBAiSIWc9GjnY1hBUErhuDQTw
X-IronPort-AV: E=Sophos;i="5.01,486,1400022000"; 
   d="scan'208";a="462724095"
Received: from host-2-96-158-225.as13285.net (HELO localhost) ([2.96.158.225])
  by out1.ip04ir2.opaltelecom.net with ESMTP; 16 Jun 2014 13:55:47 +0100
X-Mailer: git-send-email 1.9.4.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251715>

A recent review comment highlighted the current view on error
message punctuation. I thought it worth recording.

In the past I've also seen guidance on the error message style.
This patch also gives a place for recording such guidance, for
example, ensuring that the message is useful to the user, rather
than referring to some internal technical issue. I haven't looked
deeply for those yet.

Philip Oakley (1):
  doc: State coding guideline for error message punctuation

 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
1.9.4.msysgit.0
