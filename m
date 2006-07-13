From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error writing loose object on Cygwin
Date: Wed, 12 Jul 2006 21:27:50 -0700
Message-ID: <7vlkqyxh6h.fsf@assigned-by-dhcp.cox.net>
References: <20060712035746.GA7863@spearce.org>
	<7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607112132540.5623@g5.osdl.org>
	<20060712050016.GA8002@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 06:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0so7-0003HV-JA
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWGME15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWGME15
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:27:57 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:46774 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932196AbWGME15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 00:27:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713042756.DAKF12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 00:27:56 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060712050016.GA8002@spearce.org> (Shawn Pearce's message of
	"Wed, 12 Jul 2006 01:00:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23806>

Shawn Pearce <spearce@spearce.org> writes:

> Tomorrow when I get access to my Cygwin system again I'll try to
> write up a tiny test case which shows the error behavior we are
> seeing and send it to the Cygwin mailing list, as this really does
> seem to be a Cygwin or Windows issue.  But of course having GIT
> handle this case slightly better wouldn't be bad either.  :-)

Surely, and thanks.  I'll await for a follow-up report, and
until then will hold onto this patch.
