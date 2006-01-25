From: Andreas Ericsson <ae@op5.se>
Subject: Re: [QUESTION] What is a tag for?
Date: Wed, 25 Jan 2006 10:02:12 +0100
Message-ID: <43D73E94.3020904@op5.se>
References: <1137538344.9104.34.camel@malory> <43CE19F2.6000709@op5.se>	<7vfynlwg8n.fsf@assigned-by-dhcp.cox.net> <43CE8DFB.9070004@op5.se> <7vbqy13vq9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 10:02:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1gXj-0000Rf-Jo
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 10:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWAYJCP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 04:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWAYJCO
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 04:02:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:15530 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750964AbWAYJCN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 04:02:13 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 824106BD17
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 10:02:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
In-Reply-To: <7vbqy13vq9.fsf@assigned-by-dhcp.cox.net>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15124>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>I'll apply (and test) Linus suggestions of new refs and re-send it
>>when I'm done watching King-Kong and stuffing my face with popcorn.
> 
> 
> It appears you have not finished watching the movie yet, so I
> took the liberty of adding this on top of your patch myself
> ;-).
> 

Sorry about that. I started adding stuff to it to disallow creating 
branches that have no unique commits, and then thought of some other fun 
stuff that's a bit specific to the place I work so I never got around to it.

Somehow the phb's never grow tired of coming up with new ways to waste 
my time just when I've found a way to save some, forcing me to find a 
way to find some more. Anyways, if anybody wants an update-hook to 
update a project-management tool with worked time, gimme a holler. It's 
quite neat but completely flawed in a good way. :)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
