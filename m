From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: SVN -> Git *but* with special changes
Date: Mon, 09 Jan 2012 09:26:53 +0100
Message-ID: <4F0AA4CD.2080102@alum.mit.edu>
References: <1317227849979-6840904.post@n2.nabble.com> <20110928190445.GC1482@sigill.intra.peff.net> <1325999031923-7163706.post@n2.nabble.com> <20120108051051.GA10129@sigill.intra.peff.net> <1325999865995-7163737.post@n2.nabble.com> <1326000327637-7163752.post@n2.nabble.com> <20120108103303.GC2714@centaur.lab.cmartin.tk> <m2hb06mpwn.fsf@linux-m68k.org> <20120108120807.GA7360@angband.pl> <1326061722334-7165979.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Abscissa <bus_nabble_git@semitwist.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 09:27:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkAZQ-00050Y-1q
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 09:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355Ab2AII1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 03:27:00 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59580 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab2AII1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 03:27:00 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q098Qr43008975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 9 Jan 2012 09:26:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <1326061722334-7165979.post@n2.nabble.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188159>

On 01/08/2012 11:28 PM, Abscissa wrote:
> In answer to someone's question, yea, it's Ubuntu (Kubuntu 10.04, and yea, I
> know that's old, but it's not my primary system and I haven't had a chance
> yet to upgrade it and get everything set back up again). I also tried it on
> a Debian 6 Live/Persistent system and got the same results...apparently for
> the same reason.

For Ubuntu users: there is a git PPA [1] which usually has quite
up-to-date git packages for recent Ubuntu releases.  If you configure
your system to use this PPA (instructions are on the page) then you can
stay up-to-date with minimal effort.  Currently they have version
1.7.8.2 available for hardy, lucid, maverick, natty, and oneiric and
older versions for some other Ubuntu releases.

Caveat: I am not affiliated with the PPA and cannot vouch for its integrity.

Michael

[1] https://launchpad.net/~git-core/+archive/ppa

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
