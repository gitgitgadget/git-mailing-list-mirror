From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Licensing a file format (was Re: SVN Branch Description Format)
Date: Mon, 19 Mar 2012 20:31:41 +0000
Message-ID: <4F6797AD.2070501@pileofstuff.org>
References: <4F5C85A3.4080806@pileofstuff.org> <4F668BD4.70808@pileofstuff.org> <20120319013422.GC19680@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Sayers <andrew-20120318@pileofstuff.org>,
	Git Mailing List <git@vger.kernel.org>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Nathan Gray <n8gray@n8gray.org>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>, semen.vadishev@tmatesoft.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 21:31:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9jFA-0000kU-J3
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 21:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643Ab2CSUbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 16:31:47 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:19782 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752752Ab2CSUbq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Mar 2012 16:31:46 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120319203144.LXOK20752.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Mon, 19 Mar 2012 20:31:44 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120319203144.YTSY23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Mon, 19 Mar 2012 20:31:44 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <20120319013422.GC19680@burratino>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=jVv34ezM4nwA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8 a=2o0rwsxK18A_E8S9_SgA:9 a=WqnpPMN0tdmfrt0RlckA:7 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193456>

On 19/03/12 01:34, Jonathan Nieder wrote:
> Hi Andrew,
> 
> Andrew Sayers wrote:
> 
>> I'm planning to release the spec under a Creative Commons
>> Attribution-NoDerivs license
> [...]
>> So the big question - would you be more inclined to use/contribute to
>> the SVN Branch Description Format if it had a different license?
> 
> Yes.  By the way, I think fear of forking/discussion of potential
> improvements/translation into other languages in the context of
> standards is misguided.  If you would like legal protection for your
> standard, that is what trademark law is for.
> 
> Kind regards,
> Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Could you expand on this?  A quick tour of the git codebase suggests
your objection is just to the "no derivatives" bit for documentation,
and not to the MIT license for code?

It sounds like you're saying that forking isn't a big real-world
problem, which I guess makes sense - it'll all work out in the end as
long as a single standard is in everybody's interests.  So the CC-BY
license is my favourite for now.

	- Andrew
