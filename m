From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 15 Jan 2010 17:18:53 -0800
Message-ID: <4B5113FD.9020004@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> 	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> 	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> 	<fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com> 	<4B510217.8060200@eaglescrag.net> <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com> 	<4B51082B.5030508@eaglescrag.net> <fabb9a1e1001151644n65577c99qe41327b66de28114@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pieter@frim.nl>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:19:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVxJp-0003ZK-Cw
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758550Ab0APBTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758390Ab0APBTJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:19:09 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:48190 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab0APBTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:19:07 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0G1Ir6U008543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 15 Jan 2010 17:18:53 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <fabb9a1e1001151644n65577c99qe41327b66de28114@mail.gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 15 Jan 2010 17:18:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137189>

On 01/15/2010 04:44 PM, Sverre Rabbelier wrote:
> Heya,
> 
> On Sat, Jan 16, 2010 at 01:28, J.H. <warthog19@eaglescrag.net> wrote:
>>> <!-- GitLink[git-name] Because Linus is an egotistical git -->
>>
>> Probably, should be fixed now, found it on GitBot too.
> 
> I guess you removed them rather than turning them in to comments
> (probably due to MediaWiki's lake of comments)? Works for me, we can
> figure out something else for gitbot. A regular text file that it can
> slurp or something. We being Pieter perhaps (as he is the original author)?
> 

The templates giving me a PITA trying to get it to actually generate a
comment, easiest thing might be to hide it in the span or something, or
add the comments in manually.

- John 'Warthog9' Hawley
