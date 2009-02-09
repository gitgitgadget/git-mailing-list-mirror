From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 20:20:43 +0100
Organization: Beonex
Message-ID: <4990820B.504@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbiY-0001dz-QN
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbZBITV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZBITV0
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:21:26 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:53135 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860AbZBITV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:21:26 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id 64226303C560;
	Mon,  9 Feb 2009 20:21:33 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109109>

On 09.02.2009 20:14, Johannes Schindelin wrote:
> On 09.02.2009 19:54, Brandon Casey wrote:
>>> I will follow up with an example patch which has the control
>>> characters in it.
>>>        

> Especially the "Save" command will save the byte-identical body of the
> mail.
>    

I think Thunderbird will also save a byte-identical copy of the mail, if 
you use File | Save... and use ".eml" (for email = RFC822) file extension.

The dialog is sensitive to the file extension and determines the format 
based on that, but is unfortunately not communicative about it.

If you save as HTML (.html) or plaintext (.txt), it runs it through the 
MIME converters and reformats it for display / human reading.
