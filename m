From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Tue, 19 Feb 2008 09:06:57 +1300
Message-ID: <47B9E561.8040605@catalyst.net.nz>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802181627340.30505@racer.site> <7v1w7ap0vo.fsf@gitster.siamese.dyndns.org> <47B9D484.1020304@catalyst.net.nz> <alpine.LSU.1.00.0802181942230.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:08:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCHj-0003cK-8V
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:08:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760902AbYBRUHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760908AbYBRUHn
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:07:43 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:34678 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760884AbYBRUHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:07:42 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JRCGn-0003CD-8z; Tue, 19 Feb 2008 09:07:30 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LSU.1.00.0802181942230.30505@racer.site>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74339>

Johannes Schindelin wrote:
> Well, please try for yourself.  If it works for you, then I probably had 
> another error in my patch.

$ perl -MFile::Basename -e 'print basename("/foo/bar/baz");'
baz

Johannes, what are you smoking? No PUI here! ;-)



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
