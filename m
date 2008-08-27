From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 01:53:50 +0200
Message-ID: <48B5E90E.3000601@s5r6.in-berlin.de>
References: <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>	<7vy72kek6y.fsf@gitster.siamese.dyndns.org>	<20080826145719.GB5046@coredump.intra.peff.net>	<1219764860.4471.13.camel@gaara.bos.redhat.com>	<1219766398.7107.87.camel@pmac.infradead.org>	<alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>	<20080826180926.GA25711@isilmar.linta.de>	<alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>	<23DFA9EC-9523-4179-BA3C-ACBDB82953DF@cs.indiana.edu>	<alpine.DEB.1.10.0808271126190.10784@gandalf.stny.rr.com> <20080827230903.GB11005@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	=?ISO-8859-1?Q?Kristian_H=F8g?= =?ISO-8859-1?Q?sberg?= 
	<krh@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Perry Wagle <wagle@cs.indiana.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:56:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUs0-0005NK-BG
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYH0XzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbYH0XzH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:55:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:49903 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbYH0XzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:55:06 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m7RNrt2s025161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Aug 2008 01:53:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080722 SeaMonkey/1.1.11
In-Reply-To: <20080827230903.GB11005@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.95.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93992>

Russell King wrote:
> And no warnings before hand that the commands you were using were
> deprecated.

(a) They weren't deprecated, they were moved into a different directory.

(b) There have been several announcements of the 1.6.0 prereleases and 
the 1.6.0 release crossposted.  Of course somebody forgot to tell you 
what you will learn from these release notes.  Unfair.

(c) There do happen unannounced software updates on shell servers over 
which you don't have control.  Ask for your money back.

(d) "-" -> " "?  Molehill.
-- 
Stefan Richter
-=====-==--- =--- ===--
http://arcgraph.de/sr/
