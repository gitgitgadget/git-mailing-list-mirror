From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Fri, 15 Jan 2010 16:28:27 -0800
Message-ID: <4B51082B.5030508@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> 	<4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> 	<4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> 	<fabb9a1e1001151521s1837b3d5o2a35cb5bb35c8038@mail.gmail.com> 	<4B510217.8060200@eaglescrag.net> <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVwWt-000446-VZ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab0APA2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077Ab0APA2f
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:28:35 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51788 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab0APA2e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:28:34 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0G0SRCh004265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Fri, 15 Jan 2010 16:28:27 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <fabb9a1e1001151608k6911bcf8p854d97c2f2d46264@mail.gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Fri, 15 Jan 2010 16:28:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137172>

On 01/15/2010 04:08 PM, Sverre Rabbelier wrote:
> Heya,
> 
> On Sat, Jan 16, 2010 at 01:02, J.H. <warthog19@eaglescrag.net> wrote:
>> If you can be more specific I can go through and fix it...
> 
>>From the original faq:
> 
> <<GitLink(git-name, Because Linus is an egotistical git)>>
> 
> Is translated to
> 
> <<[[GitLink]](git-name, Because Linus is an egotistical git}}
> 
> But should instead be turned into a comment (from the source of the faq):
> 
> <!-- GitLink[git-name] Because Linus is an egotistical git -->
> 
>> There's some
>> extraneous bits on the page that I haven't figured out what they were
>> for originally but most everything on the page seems to work fine for me...
> 
> We're probably referring to the same then :).

Probably, should be fixed now, found it on GitBot too.

- John 'Warthog9' Hawley
