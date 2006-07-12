From: Junio C Hamano <junkio@cox.net>
Subject: Re: Error writing loose object on Cygwin
Date: Tue, 11 Jul 2006 21:15:38 -0700
Message-ID: <7vr70r1ms5.fsf@assigned-by-dhcp.cox.net>
References: <20060712035746.GA7863@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 06:15:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0W8V-0005Fb-2Q
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 06:15:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWGLEPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 00:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWGLEPk
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 00:15:40 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46538 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932367AbWGLEPj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 00:15:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712041539.QOJG19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 00:15:39 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060712035746.GA7863@spearce.org> (Shawn Pearce's message of
	"Tue, 11 Jul 2006 23:57:46 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23759>

Shawn Pearce <spearce@spearce.org> writes:

> Has anyone else seen this type of behavior before?  Any suggestions
> on debugging this issue?

I would suggest raising this (politely) to Cygwin people.
