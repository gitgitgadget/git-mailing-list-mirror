From: Andreas Ericsson <ae@op5.se>
Subject: Re: [wish] Auto-generate gitk's pretty pictures
Date: Sat, 14 Jan 2006 14:36:47 +0100
Message-ID: <43C8FE6F.4050206@op5.se>
References: <46a038f90601121302x3d06898dk3f9a0ab7114ef70a@mail.gmail.com>	 <40b2b7d90601131414o20eae573r23256ff2dfbeffa5@mail.gmail.com>	 <46a038f90601131444m32a1a8b8w7ab16617f15ab93b@mail.gmail.com> <40b2b7d90601131905s6bb9954fk8e359e3f066ce0c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 14:37:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exlaf-0002K2-FZ
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 14:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWANNhF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 08:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWANNhF
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 08:37:05 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:17081 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932264AbWANNhE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 08:37:04 -0500
Received: from [82.182.116.45] (1-2-9-7b.gkp.gbg.bostream.se [82.182.116.45])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id AB4656BCFE; Sat, 14 Jan 2006 14:36:47 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Artem Khodush <greenkaa@gmail.com>
In-Reply-To: <40b2b7d90601131905s6bb9954fk8e359e3f066ce0c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14664>

Artem Khodush wrote:
> On 1/14/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> 
>>That looks *great* -- How hard would it be to run it alongside gitweb,
>>with links back to gitweb for showing commits? And... what is it
>>written in?
> 
> 
> It's written mainly in HTML+javascript, so linking to and from it should
> be simple - just add an <a> tag. But, the next feature I plan to add
> is to show commits in the same window in a way like gitk does.
> 

Why not just have a separate frame for the commits and load gitweb.cgi 
there?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
