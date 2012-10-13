From: perryh@pluto.rain.com
Subject: Re: A design for subrepositories
Date: Sat, 13 Oct 2012 14:20:42 -0700
Message-ID: <507a3d9a.j+V+kkG9pRPJs4kM%perryh@pluto.rain.com>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: la@iki.fi
X-From: git-owner@vger.kernel.org Sat Oct 13 23:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TN9Cw-0002mX-EO
	for gcvg-git-2@plane.gmane.org; Sat, 13 Oct 2012 23:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141Ab2JMVZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 17:25:06 -0400
Received: from agora.rdrop.com ([199.26.172.34]:1466 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab2JMVZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 17:25:05 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id q9DLOw8r061351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 13 Oct 2012 14:24:58 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id q9DLOwMK061350;
	Sat, 13 Oct 2012 14:24:58 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 ([192.168.200.81]) by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA10578; Sat, 13 Oct 12 14:20:54 PDT
In-Reply-To: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207579>

"Lauri Alanko" <la@iki.fi> wrote:

> I'm going to get a bit religious here:
> anything longer than a screenful shouldn't be written in shell ...

Whence cometh this religion?  I've heard of a modularity principle
wherein no one function, in any language, ought to be longer than a
page, but what's special about shell that warrants such a further
restriction?

BTW, to adherents of the mentioned religion, this:
http://www.freebsd.org/cgi/cvsweb.cgi/ports/ports-mgmt/portmaster/files/Attic/portmaster.sh.in?rev=2.32;content-type=text/plain
-- at just under 3600 lines -- is likely one of the greater heresies
around :)
