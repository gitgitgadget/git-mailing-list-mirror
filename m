From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] bash: add support for 'git stash pop --index' option
Date: Tue, 09 Jun 2009 00:18:56 -0700
Message-ID: <7vy6s1swm7.fsf@alter.siamese.dyndns.org>
References: <d07a10275620808bc378340cc8450d3e8de8cf7e.1244501726.git.szeder@ira.uka.de>
	<e380823e9e6c895eeb375b2c5f021ff022798d30.1244501726.git.szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:19:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvbs-0000zC-4D
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbZFIHS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 03:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbZFIHS4
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:18:56 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38125 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZFIHSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 03:18:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609071858.TDFR20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jun 2009 03:18:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1jJx1c0034aMwMQ03jJx7J; Tue, 09 Jun 2009 03:18:57 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=tvac_oBH8aAA:10 a=fUg2aVyDLLoA:10
 a=JHQ8xVtZbYaEDShwcQAA:9 a=QmEY2zLWMLAqXs0lj-VubOEBmKUA:4
X-CM-Score: 0.00
In-Reply-To: <e380823e9e6c895eeb375b2c5f021ff022798d30.1244501726.git.szeder@ira.uka.de>
 ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue\,  9 Jun 2009
 00\:57\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121147>

Thanks; I'll pick up both patches.
