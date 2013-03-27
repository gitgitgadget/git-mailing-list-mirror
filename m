From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git status takes 30 seconds on Windows 7. Why?
Date: Wed, 27 Mar 2013 21:02:07 +0400
Message-ID: <20130327210207.be75b77c5cddd1e5c10764e0@domain007.com>
References: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jim Kinsman <jakinsman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:02:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKtkI-0000iy-TY
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab3C0RCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:02:13 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:36642 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab3C0RCM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:02:12 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r2RH27bv021082;
	Wed, 27 Mar 2013 21:02:08 +0400
In-Reply-To: <CAFT1WNyyXbCOQWMt8nYife7Tix_mJzDQrj5e+N=GKbDR8OyYzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219275>

On Wed, 27 Mar 2013 11:39:31 -0500
Jim Kinsman <jakinsman@gmail.com> wrote:

> git status takes 30 seconds on Windows 7. Here are some stats:
[...]
> What can I do??? This is so slow it is unbearable.
> By the way i've done git gc several times and nothing changed.

You could try some voodoo [1] or experimental caching features [2].

1. http://groups.google.com/group/msysgit/browse_thread/thread/02e3c0e046f07215
2. http://groups.google.com/group/msysgit/browse_thread/thread/7cbfe3ca452650d1/93ce48e3875f7416
