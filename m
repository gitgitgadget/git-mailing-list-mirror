From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] defaults for where to merge from (take 3)
Date: Fri, 02 Mar 2007 01:57:47 -0800
Message-ID: <7virdkezms.fsf@assigned-by-dhcp.cox.net>
References: <es450f$d58$1@sea.gmane.org> <45E68EDE.2090405@lu.unisi.ch>
	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	<45E69297.8070001@lu.unisi.ch>
	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	<45E69EEE.8070905@lu.unisi.ch>
	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	<7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703010242t36cea2fdr676c1adb799c8077@mail.gmail.com>
	<7vlkigmeqh.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703020105o128fc3adq2912e43d5af74dca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:57:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4WO-00031g-Lt
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422993AbXCBJ5t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 04:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbXCBJ5t
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:57:49 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:48011 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422993AbXCBJ5t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:57:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302095749.NDJJ26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 04:57:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vlxn1W00H1kojtg0000000; Fri, 02 Mar 2007 04:57:48 -0500
In-Reply-To: <81b0412b0703020105o128fc3adq2912e43d5af74dca@mail.gmail.com>
	(Alex Riesen's message of "Fri, 2 Mar 2007 10:05:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41177>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> ..., and will be only slightly
> pleased if creation of a tracked branch is more
> noticeable (see the mail regarding message on
> branch creation).

I would very much agree on this part, regardless of what the
default would end up to be.
