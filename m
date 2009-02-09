From: Ben Bucksch <ben.bucksch.news@beonex.com>
Subject: Re: Thunderbird and patches (was Re: [PATCH v2] Enable setting attach
   as the default in .gitconfig   for git-format-patch.)
Date: Mon, 09 Feb 2009 20:59:22 +0100
Organization: Beonex
Message-ID: <49908B1A.7040101@beonex.com>
References: <498E50E2.8050309@codeweavers.com> <200902072310.12764.bss@iguanasuicide.net> <498F01C2.5080105@codeweavers.com> <alpine.DEB.1.00.0902081827140.10279@pacific.mpi-cbg.de> <499022D3.3000200@drmicha.warpmail.net> <49902EDC.6020901@beonex.com> <alpine.DEB.1.00.0902091433270.10279@pacific.mpi-cbg.de> <49903521.1060101@codeweavers.com> <49903B27.8070608@beonex.com> <49904DE7.2080205@codeweavers.com> <4990519C.8060601@drmicha.warpmail.net> <499058B4.4070009@beonex.com> <qXxPO6LuQr7-9QoWMdojOMbuADIJ55oaOVr5t_8eLGR9vvNpW72wyA@cipher.nrlssc.navy.mil> <49907F75.2050100@beonex.com> <alpine.DEB.1.00.0902092013260.10279@pacific.mpi-cbg.de> <4990820B.504@beonex.com> <r57oMSnamWCJ1G1-r98G6mYQjX0YNpQz1OzEBHSrDifmBU_ir2P77A@cipher.nrlssc.navy.mil> <49908927.2030408@beonex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeremy White <jwhite@codeweavers.com>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Mon Feb 09 21:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWcK7-0006fx-Bt
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091AbZBIUAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757444AbZBIUAG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:00:06 -0500
Received: from mail.server.beonex.com ([78.46.195.11]:38520 "EHLO
	mail.server.beonex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756953AbZBIUAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:00:05 -0500
Received: from [10.1.1.3] (localhost [127.0.0.1])
	by mail.server.beonex.com (Postfix) with ESMTP id BB15B303C561;
	Mon,  9 Feb 2009 21:00:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2a1pre) Gecko/20081217 Shredder/3.0b2pre
In-Reply-To: <49908927.2030408@beonex.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109116>

On 09.02.2009 20:51, Ben Bucksch wrote:
> On 09.02.2009 20:30, Brandon Casey wrote:
>> Did you try it with the message I sent titled
>> '[PATCH] example patch corrupted by thunderbird'?
>
> I tried now, and none of the editors/viewers I tried are displaying 
> anything that would come close to readable to me, even if you count 
> clearly marked hex character codes as readable. I tried less, e3 and 
> kwrite. Therefore, a) I can't verify whether the result is correct or not

I now compared the result of File | Save as.... (main menu, not context 
menu) | "1.eml" with the email on the cyrus server, and they are 
identical (diff and md5sum). So, TB *does* save it correctly, byte-for-byte.
