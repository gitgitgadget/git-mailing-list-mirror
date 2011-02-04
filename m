From: Miles Bader <miles@gnu.org>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Fri, 04 Feb 2011 11:06:48 +0900
Message-ID: <87bp2sy2mf.fsf@catnip.gol.com>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
	<AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
	<AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 03:07:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlB4g-0001Sx-PT
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 03:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab1BDCG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 21:06:57 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:55600 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753721Ab1BDCG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 21:06:56 -0500
Received: from 218.33.195.219.eo.eaccess.ne.jp ([218.33.195.219] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1PlB4T-00089I-SJ; Fri, 04 Feb 2011 11:06:49 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 07A29DF93; Fri,  4 Feb 2011 11:06:49 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
	(Hilco Wijbenga's message of "Thu, 3 Feb 2011 13:42:27 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166019>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> Quite frankly, I'm surprised there are (presumably experienced)
> developers who do not immediately see the value of a little
> organization. Surely, given the use of code conventions, formatting
> rules, etcetera, the obvious one step further is to also organize
> where the files go?

I think one of the problems is that what's been suggested seems like
window-dressing.  Moving everything into src/ and calling it "organized"
doesn't actually accomplish much other than perhaps making the README
file more visible to newbs; things are _still_ a mess, just a mess with
four more letters...

-Miles

-- 
Back, n. That part of your friend which it is your privilege to contemplate in
your adversity.
