From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] config: Add --null/-z option for null-delimted output
Date: Tue, 26 Jun 2007 19:14:07 -0700
Message-ID: <7vodj2rvo0.fsf@assigned-by-dhcp.pobox.com>
References: <200706220156.01175.jnareb@gmail.com>
	<11827802382221-git-send-email-frank@lichtenheld.de>
	<200706260129.47518.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3N2w-000108-DF
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbXF0COP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbXF0COO
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:14:14 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43518 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbXF0COM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:14:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627021409.BBFY3993.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:14:11 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSE71X00F1kojtg0000000; Tue, 26 Jun 2007 22:14:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51011>

Thanks for the sharp eyes.
