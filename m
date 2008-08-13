From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: Re: [ANNOUNCE] GIT 1.6.0-rc3
Date: Wed, 13 Aug 2008 12:24:55 +0200
Message-ID: <48A2B677.90400@jaeger.mine.nu>
References: <7viqu5nw9x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 12:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTDYI-0001Te-E6
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 12:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbYHMKY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 06:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752622AbYHMKY6
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 06:24:58 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:57391 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751486AbYHMKY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 06:24:57 -0400
Received: (qmail 10865 invoked from network); 13 Aug 2008 10:24:55 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 13 Aug 2008 10:24:55 -0000
Received: (qmail 915 invoked from network); 13 Aug 2008 10:24:55 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 13 Aug 2008 10:24:55 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <7viqu5nw9x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92205>

Junio C Hamano wrote:
> The last rc before the final, 1.6.0-rc3, can be found at the usual places:
>   

The git://git.kernel.org/pub/scm/git/git.git repo is missing a 
v1.6.0-rc3 tag.

I've checked the current master branch (04c6e9e), but it does not 
contain the gitk fix from Alexander Gavrilov ([PATCH (GITK BUGFIX)] 
gitk: Allow safely calling nukefile from a run queue handler.); Paul 
Mackerras said he applied it (somewhere); I just think that this is an 
issue that will probably bite many people and so should be fixed in 1.6.0.

Christian.
