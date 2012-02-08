From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Fix build problems related to profile-directed
 optimization
Date: Wed, 8 Feb 2012 13:53:19 -0500
Message-ID: <20120208185319.GB9397@thunk.org>
References: <20120206055750.GA6615@thunk.org>
 <1328508017-7277-1-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 19:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvCdy-0001tL-PW
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 19:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757226Ab2BHSxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 13:53:22 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:59331 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756942Ab2BHSxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 13:53:22 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RvCdt-0005pP-0N; Wed, 08 Feb 2012 18:53:21 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RvCdr-0003Z6-UQ; Wed, 08 Feb 2012 13:53:19 -0500
Content-Disposition: inline
In-Reply-To: <1328508017-7277-1-git-send-email-tytso@mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190246>

Junio, any comments on my most recent spin of this patch?  Any changes
you'd like to see?

Thanks,

					- Ted
