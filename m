From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Install templates with the user and group of the
	installing personality
Date: Wed, 20 Aug 2008 13:20:01 -0400
Message-ID: <20080820172000.GB27773@sigill.intra.peff.net>
References: <1219246585-31993-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrMr-0005ZW-Eu
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYHTRUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 13:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYHTRUE
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:20:04 -0400
Received: from peff.net ([208.65.91.99]:3723 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbYHTRUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:20:03 -0400
Received: (qmail 24966 invoked by uid 111); 20 Aug 2008 17:20:02 -0000
Received: from lawn-128-61-25-158.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.158)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Aug 2008 13:20:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 13:20:01 -0400
Content-Disposition: inline
In-Reply-To: <1219246585-31993-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92996>

On Wed, Aug 20, 2008 at 05:36:25PM +0200, Johannes Sixt wrote:

>  I hope this tar option 'o' is universal enough. Even my ancient AIX 4.3.3
>  box has it.

The oldest thing I have is Solaris 5.8, which also has it.

-Peff
