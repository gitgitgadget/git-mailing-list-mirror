From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Fix bad quoting in documentation
Date: Sat, 16 Jan 2010 13:58:59 +0200
Message-ID: <871vhqi7lo.fsf@mithlond.arda>
References: <f3271551001160002r25cb0ac7hc96891f4af22bd03@mail.gmail.com>
	<201001161120.14846.trast@student.ethz.ch>
	<f3271551001160300m24932ad4wfd72abc826f2bb65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 12:59:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NW7JQ-0000nZ-DR
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 12:59:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab0APL7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 06:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365Ab0APL7V
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 06:59:21 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:34765 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab0APL7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 06:59:20 -0500
Received: from mithlond.arda (84.251.132.215) by jenni1.inet.fi (8.5.014)
        id 4B17DDDA01BF8EF1; Sat, 16 Jan 2010 13:59:15 +0200
Received: from dtw by mithlond.arda with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1NW7Iy-000240-1T; Sat, 16 Jan 2010 13:59:00 +0200
In-Reply-To: <f3271551001160300m24932ad4wfd72abc826f2bb65@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 16 Jan 2010 16:30:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137226>

On 2010-01-16 16:30 (+0530), Ramkumar Ramachandra wrote:

>> If not, please tell the debian guys to set ASCIIDOC8=YesPlease when
>> building the docs.
>
> Thanks! The Makefile clearly points this out. I'll let the Debian
> people know.

Git 1:1.6.6-1 in Debian's unstable repository is built with
ASCIIDOC8=YesPlease and ASCIIDOC_NO_ROFF=Yes options.
