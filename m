From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] Enable setting attach as the default in .gitconfig
   for git-format-patch.
Date: Mon, 09 Feb 2009 13:34:27 +0100
Message-ID: <499022D3.3000200@drmicha.warpmail.net>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org, mozeditor@floppymoose.com,
	ben.bucksch@beonex.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 13:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWVMq-0005Hd-MK
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 13:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbZBIMef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 07:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755148AbZBIMee
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 07:34:34 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48422 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755111AbZBIMed (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2009 07:34:33 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D88FC29002B;
	Mon,  9 Feb 2009 07:34:32 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 09 Feb 2009 07:34:32 -0500
X-Sasl-enc: Qf71YPicnkYDpelxVb7cmrQQ43oLG79lj+hNt+shubQC 1234182872
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 950F1132EC;
	Mon,  9 Feb 2009 07:34:31 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109066>

Johannes Schindelin venit, vidit, dixit 08.02.2009 18:28:
> Hi,
> 
> On Sun, 8 Feb 2009, Jeremy White wrote:
> 
>> As an aside, there is a long (and discouraging) read about the issue
>> with Thunderbird here:
>>   https://bugzilla.mozilla.org/show_bug.cgi?id=141983
>>
>> Essentially, the problem is well understood - Thunderbird uses
>> format=flowed by default, which is what mangles the patches.  The author
>> of the relevant code is unmoved by arguments that the default should
>> switch, and no one has yet been willing to create a simpler UI for
>> switching the setting.
> 
> I guess I'll start discouraging use of Thunderbird from now on. 

...specifically for patch submission, please ;)
I'm a TB user who compiles the beast and writes extensions for it, and
yet I found git-send-email the more reliable and practical solution for
sending out patches. Put yourself in bcc and you'll have a copy in TB's
inbox or another folder (use filters).

> Seems 
> that not even the opposition of a guy named Andrew Morton was clue bat 
> enough.

<sarcasm style="reality: exaggerated;">
Isn't that some Linux guy? How would he matter for Mozilla? Does he even
know how to send HTML mail...
</sarcasm>

Michael
