From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Fix sorting changelists when cloning a Perforce repository
Date: Mon, 13 Aug 2007 16:51:22 -0700
Message-ID: <7vtzr3dmdh.fsf@assigned-by-dhcp.cox.net>
References: <3f4fd2640708131150r1d9fb02ai1f655a22658cb544@mail.gmail.com>
	<200708132345.23647.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Reece Dunn" <msclrhd@googlemail.com>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 01:51:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKjh6-0000kn-4S
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 01:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763156AbXHMXvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 19:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761547AbXHMXvY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 19:51:24 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53661 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758719AbXHMXvX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 19:51:23 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070813235122.THFF1335.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 13 Aug 2007 19:51:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bbrM1X00c1kojtg0000000; Mon, 13 Aug 2007 19:51:22 -0400
In-Reply-To: <200708132345.23647.simon@lst.de> (Simon Hausmann's message of
	"Mon, 13 Aug 2007 23:45:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55798>

Thanks, both.
