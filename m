From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: Git Screencast ?
Date: Fri, 23 Nov 2007 11:14:27 +0100
Message-ID: <20071123101426.GA15902@dualtron.vpn.rwth-aachen.de>
References: <fi1a9f$30q$1@ger.gmane.org> <47453C6D.1080403@op5.se> <fi5bet$brl$1@ger.gmane.org>
Reply-To: Johannes Gilger <heipei@hackvalue.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: git@vger.kernel.org
To: Michael Donaghy <mike@mikedonaghy.org>
X-From: git-owner@vger.kernel.org Fri Nov 23 11:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvVXT-0001x2-9l
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 11:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125AbXKWKNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 05:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755074AbXKWKNQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 05:13:16 -0500
Received: from avalon.gnuzifer.de ([85.10.199.84]:43269 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbXKWKNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 05:13:15 -0500
Received: from 0-031.vpn.rwth-aachen.de ([134.130.240.31]:45675 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <heipei@hackvalue.de>)
	id 1IvVX5-0007fj-SZ; Fri, 23 Nov 2007 11:13:12 +0100
Content-Disposition: inline
In-Reply-To: <fi5bet$brl$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-SA-Exim-Connect-IP: 134.130.240.31
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65889>

On 22/11/07 20:47, Michael Donaghy wrote:
> Yes thank you , although a screen cast would still be ideal , the 
> documentation is very good,
> also , what do you think of git-gui ? , I think it is the best one

Hi Michael,

I think you're trying to hide the complexity of git. The problem with 
graphical tools is that they hide complexity from the user, which in 
some cases is only possibly/good if the user has understood the 
underlying principles already. Also I think that there are many things 
which can be done much quicker using a command-line than any gui (as all 
of the people here will agree). Git is not Time-Machine (this thing from 
Apple). It is also no good idea to try to view git from a svn's point of 
view, or try to compare commands. It took me a while to get over that 
and accept that git is different. I was frustated (and still am 
sometimes) but i finally understood the whole concept.

About screencasts: I haven't watched that many screencasts in general, 
but I can hardly imagine that they are better way of teaching things 
than reading a manual. Watching someone type in commands, hitting 
"Pause", then trying it myself doesn't seem more intuitive to me than 
just reading a manual and typing the commands given in regular 
intervals. Maybe someone can enlighten me about the use of screencasts 
(in a command-line environment).

Greetings,
Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
