From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: Has the git shell revert been done so master should work?
Date: Tue, 26 Aug 2008 04:03:57 -0600
Message-ID: <alpine.LNX.1.10.0808260401280.11123@suse104.zenez.com>
References: <alpine.LNX.1.10.0808240659350.16122@xenau.zenez.com> <20080824173804.GA26626@coredump.intra.peff.net> <alpine.LNX.1.10.0808242332580.6062@xenau.zenez.com> <7vej4dire6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 12:05:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXvQA-0006VJ-HN
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 12:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbYHZKEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 06:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752680AbYHZKD7
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 06:03:59 -0400
Received: from suse104.zenez.com ([198.60.105.164]:29378 "EHLO
	suse104.zenez.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbYHZKD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 06:03:59 -0400
Received: by suse104.zenez.com (Postfix, from userid 1000)
	id EEC19A7C891; Tue, 26 Aug 2008 04:03:57 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by suse104.zenez.com (Postfix) with ESMTP id 9E920A7C88F;
	Tue, 26 Aug 2008 04:03:57 -0600 (MDT)
In-Reply-To: <7vej4dire6.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93730>

On Sun, 24 Aug 2008, Junio C Hamano wrote:
> But I've already pushed out the 'master' with the workarounds, so it
> should not be necessary anymore.  Please check if tonight's 'master' works
> for you.

This allow 1.6.0 with fixes to compile.  I now have to figure out why some 
tests fail.  It seems different tests fail on various platforms but that 
is an other issue.  I will get back to the list with new questions at that 
time.  But this does solve the problems with compiling.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
