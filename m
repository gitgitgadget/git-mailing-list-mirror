From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 13:56:27 +0200
Message-ID: <48B3EF6B.7070400@s5r6.in-berlin.de>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>	<1219664940.9583.42.camel@pmac.infradead.org>	<48B3715D.7020608@gmail.com>	<20080826091701.2e4e3ff4@hyperion.delvare> <48B3E517.2040409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jean Delvare <khali@linux-fr.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 26 13:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXxBj-0005Tm-Qx
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 13:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbYHZL5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 07:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753520AbYHZL5P
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 07:57:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47638 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYHZL5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 07:57:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.42] ([83.221.231.7])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id m7QBuXCa016809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Aug 2008 13:56:34 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080722 SeaMonkey/1.1.11
In-Reply-To: <48B3E517.2040409@gmail.com>
X-Enigmail-Version: 0.95.6
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93738>

A Large Angry SCM wrote:
> Jean Delvare wrote:
>> On Mon, 25 Aug 2008 22:58:37 -0400, A Large Angry SCM wrote:
>>> David Woodhouse wrote:
>>>>   (C) Just don't do it. Leave the git-foo commands as they were. They
>>>>       weren't actually hurting anyone, and you don't actually _gain_
>>>>       anything by removing them. For those occasional nutters who
>>>>       _really_ care about the size of /usr/bin, give them the _option_
>>>>       of a 'make install' without installing the aliases.
>>> Acked-by: A Large Angry SCM <gitzilla@gmail.com>
[...]
> Do some research; [...]

...the plan to move git-foo out of /usr/bin has been discussed and 
wrapped up quite a while ago (am I confident to say without being 
subscriber of git@vger.k'org myself).

Instead of unhelpful complaints after the fact, you could try which of 
the many available alternatives work for you:  Extended PATH, shell 
aliases, command line completion setup, links in ~/bin, or so many other 
possibilities of varying degree of sophistication.  If none of these fix 
whatever issues you experience, there is surely opportunity to discuss 
details on the git list.
-- 
Stefan Richter
-=====-==--- =--- ==-=-
http://arcgraph.de/sr/
