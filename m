From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 13:15:04 +0100
Message-ID: <200612271315.05250.jnareb@gmail.com>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net> <7v1wml8wmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612271251060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 13:12:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzXds-0000uy-02
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 13:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWL0MMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 07:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWL0MMQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 07:12:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:52413 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbWL0MMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 07:12:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3858563uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 04:12:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kCt2cdeDmpNzfKEzRgTBxhzddemBxKOthaZSEdzT54f6a5Afy+if4gLsSYwfA3d1Hbs2v2fhAHtPaSSEJ8d/x2QnIuQo0olKUlOdk9CeyANwOZFwEx75hmZ1/nsp8lbtZGZF8V3MAH7HLYoPoJKMvgn5iuFTYyR3LUNdzCPLD98=
Received: by 10.67.119.13 with SMTP id w13mr11907629ugm.1167221534481;
        Wed, 27 Dec 2006 04:12:14 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id k30sm22907595ugc.2006.12.27.04.12.13;
        Wed, 27 Dec 2006 04:12:14 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0612271251060.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35466>

Johannes Schindelin wrote:

> BTW I think that latin-1 is not a valid encoding name (at least in my 
> setup it isn't), so we should rather talk about iso-8859-1.

"iconv --list" include l1 and latin1 as aliases to the proper name
of encoding, i.e. iso-8859-1; but not latin-2.
-- 
Jakub Narebski
Poland
