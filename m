From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Sun, 14 Sep 2008 23:09:55 -0700
Message-ID: <20080915060954.GA32347@linode.davidb.org>
References: <1221458331-8804-1-git-send-email-dhruva@ymail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: GIT SCM <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Dhruva Krishnamurthy <dhruva@ymail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 08:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf7Iq-0006Hh-L4
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 08:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYIOGJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 02:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYIOGJ4
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 02:09:56 -0400
Received: from linode.davidb.org ([72.14.176.16]:55219 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbYIOGJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 02:09:56 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1Kf7HX-0008VM-19; Sun, 14 Sep 2008 23:09:55 -0700
Content-Disposition: inline
In-Reply-To: <1221458331-8804-1-git-send-email-dhruva@ymail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95878>

On Mon, Sep 15, 2008 at 11:28:51AM +0530, Dhruva Krishnamurthy wrote:

>Modifying RCS keywords prevents submitting to p4 from git due to missing hunks.
>New option git-p4.kwstrip set to true or false controls the behavior.

I'm a little curious about what the problem here is.  I've been
stripping keywords out of P4 and submitting changes for many years,
and never had a problem.

I'm just wondering if we're not fixing the wrong problem here.

David
