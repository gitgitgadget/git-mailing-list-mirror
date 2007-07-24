From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add glossary that can be converted into a po file for each language.
Date: Mon, 23 Jul 2007 18:48:18 -0700
Message-ID: <7v7ioqlggt.fsf@assigned-by-dhcp.cox.net>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707212150.49351.stimming@tuhh.de>
	<7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
	<200707232216.40300.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 03:48:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID9Vo-0004zq-3o
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 03:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758444AbXGXBsV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 21:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757067AbXGXBsV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 21:48:21 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46632 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbXGXBsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 21:48:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724014818.NBAE1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Jul 2007 21:48:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TDoJ1X00j1kojtg0000000; Mon, 23 Jul 2007 21:48:19 -0400
In-Reply-To: <200707232216.40300.stimming@tuhh.de> (Christian Stimming's
	message of "Mon, 23 Jul 2007 22:16:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53519>

Christian Stimming <stimming@tuhh.de> writes:

> As I already wrote: Having a glossary in the header of the po file has 
> some (IMHO serious) drawbacks.

Yeah, that was me talking without knowing what are the usual
workflows with gettext toolchain.  A separate glossary that
properly is PO is much nicer.  We could even use that in the
help text.
