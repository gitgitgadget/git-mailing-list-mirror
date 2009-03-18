From: Sam Hocevar <sam@zoy.org>
Subject: Re: [PATCH] git-gui: minor spelling fix and string factorisation.
Date: Wed, 18 Mar 2009 23:43:02 +0100
Message-ID: <20090318224301.GH27280@zoy.org>
References: <20090318212230.GA2511@zoy.org> <7vvdq6bgzv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:44:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4VI-0007SY-Ar
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758622AbZCRWnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759579AbZCRWnI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:43:08 -0400
Received: from poulet.zoy.org ([80.65.228.129]:47648 "EHLO poulet.zoy.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760104AbZCRWnG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:43:06 -0400
Received: by poulet.zoy.org (Postfix, from userid 1000)
	id 0FD9E12040E; Wed, 18 Mar 2009 23:43:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vvdq6bgzv.fsf@gitster.siamese.dyndns.org>
Mail-Copies-To: never
X-No-CC: I read mailing-lists; do not CC me on replies.
X-Snort: uid=0(root) gid=0(root)
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113696>

On Wed, Mar 18, 2009, Junio C Hamano wrote:

> Don't you also need to adjust the existing translations if you are
> changing the key strings used by mc?

   I assumed a typical workflow where the translation coordinator
decides when to update .pot (typically at string freeze before a
release). I can provide the appropriate patch nonetheless.

-- 
Sam.
