From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Turn on USE_ST_TIMESPEC for OpenBSD
Date: Fri, 15 May 2009 11:11:12 -0700
Message-ID: <7vhbzmtewv.fsf@alter.siamese.dyndns.org>
References: <95834851-9A5E-42D8-9420-0C7505ECB1A5@newcastle.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tony Kemp <Tony.Kemp@newcastle.edu.au>
X-From: git-owner@vger.kernel.org Fri May 15 20:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M51sU-0004L7-EA
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 20:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757308AbZEOSLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 14:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756961AbZEOSLN
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 14:11:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63648 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbZEOSLM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 14:11:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090515181112.YHIZ25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 15 May 2009 14:11:12 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ruBC1b00E4aMwMQ04uBCvg; Fri, 15 May 2009 14:11:12 -0400
X-Authority-Analysis: v=1.0 c=1 a=9yDKb16lyE8A:10 a=-sgqRljCu_QA:10
 a=K6VM7zsVSlRV-xNlWJwA:9 a=8DkT3OT50gfOumn7XalipMOE9i4A:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119270>

Thanks, will queue; I have been mired in the day job.
