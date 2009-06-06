From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] enhancing builds on Solaris
Date: Fri, 05 Jun 2009 17:13:57 -0700
Message-ID: <7vbpp2fcca.fsf@alter.siamese.dyndns.org>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org>
	<67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jun 06 02:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCjYK-0003j4-Nu
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 02:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbZFFAN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 20:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZFFAN5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 20:13:57 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38731 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZFFAN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 20:13:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090606001357.UOYG17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jun 2009 20:13:57 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 0QDx1c00H4aMwMQ04QDx4P; Fri, 05 Jun 2009 20:13:58 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=sMHkdF9VCyYA:10 a=yu_NXp6HfeIA:10
 a=jHMFtF9yM-rMS47v7eMA:9 a=PG-S3KhTlFsfqHKL3gvP9kkxlKwA:4
X-CM-Score: 0.00
In-Reply-To: <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\,  5 Jun 2009 18\:36\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120850>

Looked good except for 3/8 which I did not quite understand.
