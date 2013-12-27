From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 0/5] git checkout --recurse-submodules
Date: Fri, 27 Dec 2013 14:34:31 +0100
Message-ID: <52BD81E7.40907@web.de>
References: <20131226155857.GL20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 27 14:34:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwXYq-00023X-Hb
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 14:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab3L0Nel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 08:34:41 -0500
Received: from mout.web.de ([212.227.15.3]:51630 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab3L0Nek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 08:34:40 -0500
Received: from [192.168.178.41] ([84.132.152.21]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M9GVO-1Vl2Yc14sI-00CjyX for <git@vger.kernel.org>;
 Fri, 27 Dec 2013 14:34:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131226155857.GL20443@google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:FmERU3ceCNQj0R+727qvt98IaypuGIxSnYoKLM95WPHVpGNUbmG
 kWh5SKxA+Tet78xNqYE2r4hgN+XOrO2RT90LDcQpFC7+jaZfYZ2vMDRtRdpQj7IfRHCKHQf
 C+we/4CfWTVQhAzraoZpq0pR5mNQL7ooWCmpN+QVc2UHiZH21C97c1k7rq0FIOwyOcFBj9C
 4YGM1Vwzn8nFzAupAF2sw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239725>

Am 26.12.2013 16:58, schrieb Jonathan Nieder:
> This patch series comes from
> https://github.com/jlehmann/git-submod-enhancements branch
> recursive_submodule_checkout.  It needed some tiny tweaks to apply to
> current "master" and build without warnings, but nothing major, and I
> haven't sanity checked it much beyond that and letting the kind folks
> that use Debian experimental play with it.

Cool! Thanks for rebasing this series and great to hear that more
people are using it.

> I'm sending it out now to get review and ideas for what needs to
> happen next to get this series in shape to be included in git.git.

Excellent timing, Heiko and I wanted to work on this topic in the
coming days anyway.
