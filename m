From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Wed, 20 Jul 2011 11:10:22 +0200
Message-ID: <4E269B7E.5030906@drmicha.warpmail.net>
References: <4E21D295.7020600@ramsay1.demon.co.uk> <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 11:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjSnW-0000rW-Rv
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 11:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab1GTJK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 05:10:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:32950 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751072Ab1GTJKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 05:10:25 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0AC4D20C5C;
	Wed, 20 Jul 2011 05:10:25 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 20 Jul 2011 05:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=0veJeK3H6iTP7AZJdnvVIL
	x88cA=; b=pICFwlIyY5aC2QozB+RtX/dUoEOqTW7wJAFbL9CT/vm4VDclf34Mgz
	QidFR0UM1ncF75wiEFeJQm/FdPcGzHD7/eeT2B846dYBNn/be2vFs7FgZHsHoja+
	l/U1dwoWljMGDYMKF03PfkDm7EPw88tbHXxRBhJBLoqpbP7eHYOaU=
X-Sasl-enc: TzU8DU8QJXiE7lcM5n1N3/IYNx5UYXzU8uw/f+GEkfyX 1311153024
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0DFBA451E9D;
	Wed, 20 Jul 2011 05:10:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <7vvcuy82kn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177529>

And here's just a ping post with Sam's *correct* address so that he's
not shut out but aware of the thread...
