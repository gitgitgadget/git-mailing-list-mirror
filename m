From: Kent Engstrom <kent@lysator.liu.se>
Subject: Re: Two crazy proposals for changing git's diff commands
Date: Fri, 10 Feb 2006 20:36:24 +0100
Message-ID: <m31wybknuv.fsf@athena.unit.liu.se>
References: <87slqtcr2f.wl%cworth@cworth.org> <7vfymtl43b.fsf@assigned-by-dhcp.cox.net> <87bqxgxfl7.wl%cworth@cworth.org> <7vr76c5avd.fsf@assigned-by-dhcp.cox.net> <87fymst399.wl%cworth@cworth.org> <7vfyms0x4p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Feb 11 12:11:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7sep-0007RM-EN
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 12:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWBKLLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 11 Feb 2006 06:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWBKLLM
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 06:11:12 -0500
Received: from main.gmane.org ([80.91.229.2]:1461 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751347AbWBKLLM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 06:11:12 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1F7seT-0007LG-UI
	for git@vger.kernel.org; Sat, 11 Feb 2006 12:10:53 +0100
Received: from c83-250-32-176.bredband.comhem.se ([83.250.32.176])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Feb 2006 12:10:53 +0100
Received: from kent by c83-250-32-176.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Feb 2006 12:10:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-250-32-176.bredband.comhem.se
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Cancel-Lock: sha1:m3j1dhqBZ+BKor6XIxXjHkBwzjE=
X-MIME-Autoconverted: from 8bit to quoted-printable by mail-relay.eunet.no id k1AJaRHD083583
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15936>

Junio C Hamano <junkio@cox.net> writes:
> *1* Often I find myself doing that while rewriting messy
> development history.  For example, I start doing some
> work without knowing exactly where it leads, and end up with a
> history like this:

Perhaps this discussion could be added under Documentation/howto?

/ Kent Engstr=F6m, Lysator
