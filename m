From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [RFPR] updates for 2.7?
Date: Sat, 19 Dec 2015 14:35:42 +1100
Message-ID: <20151219033542.GF422@fergus.ozlabs.ibm.com>
References: <xmqqtwnjcnrb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 04:36:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA8Jr-0006J1-5z
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 04:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbLSDfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 22:35:51 -0500
Received: from ozlabs.org ([103.22.144.67]:55410 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbbLSDfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 22:35:51 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3940B14032E; Sat, 19 Dec 2015 14:35:50 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <xmqqtwnjcnrb.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282733>

On Tue, Dec 15, 2015 at 03:09:44PM -0800, Junio C Hamano wrote:
> Git 2.7-rc1 has just been tagged, and the remainder of the year will
> be for the stabilization, fixes to brown-paper-bag bugs, reverts of
> regressions, etc., but I haven't seen updates to the various
> subsystems you guys maintain for some time.  Please throw me "this
> is a good time to pull and here are the updates" message in the
> coming few weeks.

Please do a pull from git://ozlabs.org/~paulus/gitk.git to get:

* Some improvements to gitk appearance, particularly on high DPI monitors
* Translation updates for Japanese and Swedish.

Thanks,
Paul.
