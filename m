From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
     as the default in .gitconfig   for git-format-patch.)
Date: Tue, 10 Feb 2009 11:07:05 +0100
Message-ID: <499151C9.7090502@drmicha.warpmail.net>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <RD8dEuXN_TYvtiDHum-mdwL3m_eJP49xWrl9-YgiLfhOFN6weRXVhg@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0902092105230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Ben Bucksch <ben.bucksch.news@beonex.com>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 11:08:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWpXm-00005T-CI
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 11:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZBJKHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 05:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752595AbZBJKHO
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 05:07:14 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44545 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445AbZBJKHN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 05:07:13 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 84DDA28FCBF;
	Tue, 10 Feb 2009 05:07:11 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 10 Feb 2009 05:07:11 -0500
X-Sasl-enc: P9LXgS2O4+TAuFPjg7G6CUXs3KxNxPuajW6hMkG13aU/ 1234260431
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 38445245E5;
	Tue, 10 Feb 2009 05:07:10 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <alpine.DEB.1.00.0902092105230.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109192>

Johannes Schindelin venit, vidit, dixit 09.02.2009 21:09:
> Hi,
> 
> On Mon, 9 Feb 2009, Brandon Casey wrote:
> 
>> Johannes Schindelin wrote:
>>> Hi,
>>>
>>> On Mon, 9 Feb 2009, Ben Bucksch wrote:
>>>
>>>> On 09.02.2009 19:54, Brandon Casey wrote:
>>>>> I will follow up with an example patch which has the control 
>>>>> characters in it.
>>> You can use a mailer such as Alpine, which has no problems with patches 
>>> like that whatsoever.
>> Yes, that's my work-around.  Though it's pine, we're not modern enough to
>> have alpine.
> 
> BTW it seems that a few people misunderstood my comments.
> 
> Just to clarify: I am happy if a lot of non-technical people use 
> Thunderbird.  I mean, I am happy for them.
> 
> If it is too complicated for Thunderbird to accomodate the workflow 
> required on our mailing list, however, I will have to recommend another 
> tool to the people who want to contribute to Git.
> 
> I would not recommend emacs to a vim user, either.  Or vice versa.
> 
> In other words: use the right tool.  Or, as somebody put it at the 
> GitTogether: to a hammer, everything looks like a nail.

It just seems that the workflow "required" here on the git list is the
way it is because it caters for differently abled MUAs which can't
handle certain standards (inline disposition) efficiently. Mutt
obviously can, so it's not a matter of John Doe's MUA versus geeky MUAs.

Thunderbird is differently abled also, of course, by way of definition,
but also because there's no easy way to directly feed an e-mail (or a
bunch of them) into a shell command such as git-am, e.g. So it certainly
won't be a maintainer's MUA.

When I joined the git community I adjusted my personal workflow, which
required posting by e-mail rather than nntp (gmane) and avoiding the
natural way (attachments) for patch submission, even avoiding my main
standards compliant MUA; rather than arguing for a change to the better,
more standard conforming approach, and telling people here to use MUAs
which can deal with it, i.e.: use the right tool. I know things won't
change here, just as certain people won't either.

But please don't take the status quo here as something setting global
standards. And don't take my conformance with the requirements here as
approval.

Ben has shown remarkable willingness in helping get around the
limitations of sending out patch files plainly included in e-mails, when
using TB, so let's please focus on making that successful and keep the
flame(r)s off this thread. Everyone will benefit, because it will keep
the number of misformed patches (i.e. not matching local requirements) low.

Michael
