From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: [PATCH] Update documentation to add further information about
 using Thunderbird with git-imap-send.
Date: Thu, 12 Feb 2009 15:19:08 -0600
Message-ID: <4994924C.6030100@codeweavers.com>
References: <49944570.1020805@codeweavers.com> <7vocx7jr26.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 22:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXiz9-0005qO-6D
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570AbZBLVTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZBLVTL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:19:11 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:46598 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753038AbZBLVTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:19:10 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LXixh-0008BJ-6q; Thu, 12 Feb 2009 15:19:09 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7vocx7jr26.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109659>

> True???

Yeah, TB got me.  They have two options; one is 'disable...flowed', and you
set that one to true.  The other (relevant here) is 'send...flowed', and that's
supposed to be false.  Jakub Narebski had caught that for me earlier; correct patch
sent.

Cheers,

Jeremy
