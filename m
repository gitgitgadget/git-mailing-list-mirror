From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Thu, 14 Jan 2010 10:56:40 -0800
Message-ID: <4B4F68E8.5050809@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz>	<20100114012449.GB3299@machine.or.cz>	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jan 14 19:58:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVUsH-0006CU-6E
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 19:56:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755307Ab0ANS4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 13:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756801Ab0ANS4s
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 13:56:48 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51788 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755087Ab0ANS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 13:56:48 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0EIueME007835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 14 Jan 2010 10:56:40 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <vpqbpgxrn32.fsf@bauges.imag.fr>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 14 Jan 2010 10:56:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137010>

On 01/14/2010 02:35 AM, Matthieu Moy wrote:
> "J.H." <warthog19@eaglescrag.net> writes:
> 
>> Just a heads up I've got an initial import of the current wiki up at
>> http://git.wiki.kernel.org - some of it was quite a clean conversion,
>> some of it not so much.  Please note that user accounts were not carried
>> over but edit histories were.  I'll work on cleaning up the rest of if
>> tomorrow, assuming that there isn't any objections to Petr's e-mail
>> above.
> 
> My only objection would be "Oh, migrating to another wiki engine will
> be much conversion work", but if you're willing to do it ;-).

It unfortunately goes with the territory, though I'll admit the Moinmoin
-> Mediawiki was the first conversion I've seen where even Mediawiki said:

	There are a number of hacky scripts for this. They are all
	defective in various ways - anyone who does this job does it
	precisely once, so there's no-one who really maintains a good
	converter script.

> This page seems to be an interesting test-case:
> http://git.wiki.kernel.org/index.php/GitFaq
> full of miss-imported formatting, links, ...

That's not actually the worst,

http://git.wiki.kernel.org/index.php/GitRelatedLogos

even after I've cleaned up a chunk of it is still pretty bad.

- John 'Warthog9' Hawley
