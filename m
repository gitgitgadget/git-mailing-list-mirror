From: Pierre-Olivier Vares <pov@fingerprint.fr>
Subject: Re: [BUG] (git commit --patch --message $MESSAGE) disallows hunk editing
Date: Wed, 26 Feb 2014 15:07:31 +0000 (UTC)
Message-ID: <loom.20140226T160605-845@post.gmane.org>
References: <CAM998vGieYU+8s1ermDJSfT8Zu8jDRS4WLjypraoB3iOf+qH7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 09:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIwCT-0000BU-UP
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 09:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbaB0IUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 03:20:06 -0500
Received: from plane.gmane.org ([80.91.229.3]:39457 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750813AbaB0IUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 03:20:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WIwCJ-0007uW-A1
	for git@vger.kernel.org; Thu, 27 Feb 2014 09:20:03 +0100
Received: from inv-35.192.69.109.fprt.com ([inv-35.192.69.109.fprt.com])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 09:20:03 +0100
Received: from pov by inv-35.192.69.109.fprt.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 09:20:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.69.192.35 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242791>

Max Nanasy <max.nanasy <at> gmail.com> writes:

> Tested against v1.7.12.4

Confirmed in 1.8.5.2
