From: Andreas Ericsson <ae@op5.se>
Subject: Re: [QUESTION] What is a tag for?
Date: Wed, 18 Jan 2006 19:50:35 +0100
Message-ID: <43CE8DFB.9070004@op5.se>
References: <1137538344.9104.34.camel@malory> <43CE19F2.6000709@op5.se> <7vfynlwg8n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:51:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIOL-0001gf-BN
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWARSuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWARSuh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:50:37 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:10209 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030288AbWARSug
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 13:50:36 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5EC276BCBE; Wed, 18 Jan 2006 19:50:35 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfynlwg8n.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14854>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>I'd recommend not allowing un-annotated tags in your shared repo. I
>>sent a patch for the default update-hook sometime ago that disallows
>>this. Junio seemed happy about it so I don't understand why it hasn't
>>been pushed to the master branch yet.
> 
> 
> Most likely lost in the noise.  I probably have it in my mailbox
> but not applied in any of my private branches in my repository.
> 

I'll apply (and test) Linus suggestions of new refs and re-send it when 
I'm done watching King-Kong and stuffing my face with popcorn.

-
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
