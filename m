From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Wed, 08 Dec 2010 21:28:13 -0800
Message-ID: <4D0068ED.8070409@eaglescrag.net>
References: <201011041721.53371.jnareb@gmail.com> <4D00316F.9000305@eaglescrag.net> <7v62v3ikqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 06:26:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQZ1p-0006JB-75
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 06:26:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab0LIF0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 00:26:47 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56318 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab0LIF0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 00:26:46 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB95QTrE002042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 8 Dec 2010 21:26:30 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <7v62v3ikqj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 08 Dec 2010 21:26:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163264>

On 12/08/2010 09:22 PM, Junio C Hamano wrote:
> "J.H." <warthog9@eaglescrag.net> writes:
> 
>> P.S. Most of this e-mail was written a couple of weeks ago, I found it
>> in my drafts folder and wanted to get it out along with a note that I've
>> got v8 percolating. -JH
> 
> Thanks.  Is "Tomorrow morning" relative to "a couple of weeks ago"? ;-)

No tomorrow morning is relative to today - so ~12hrs from now, ish,
maybe big ISH ;-)

I finished up the patch series today.  The series itself is already
pushed out to my repo on kernel.org

http://git.kernel.org/?p=git/warthog9/gitweb.git;a=shortlog;h=refs/heads/gitweb-ml-v8

just wanted to let that stew a bit before pushing it out to the mailing
list, since it is now an 18 part patch :-/

- John 'Warthog9' Hawley
