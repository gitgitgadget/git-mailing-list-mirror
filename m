From: "George Spelvin" <linux@horizon.com>
Subject: Re: Is there a way to cherry-pick a merge?
Date: 14 Jun 2013 23:03:27 -0400
Message-ID: <20130615030327.29278.qmail@science.horizon.com>
References: <7vobb8mk7z.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com, linux@horizon.com
X-From: git-owner@vger.kernel.org Sat Jun 15 05:03:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UngmI-0001f8-6w
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 05:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab3FODD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 23:03:28 -0400
Received: from science.horizon.com ([71.41.210.146]:22075 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751512Ab3FODD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 23:03:28 -0400
Received: (qmail 29279 invoked by uid 1000); 14 Jun 2013 23:03:27 -0400
In-Reply-To: <7vobb8mk7z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227933>

> In the meantime, "git commit --amend -C commit" would be a
> workaround, I would guess.

Ah!  A useful feature I was not familiar with.
Definitely helps a great deal.  Thank you!
