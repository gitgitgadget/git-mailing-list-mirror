From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Fri, 26 Jan 2007 08:39:46 -0800
Message-ID: <45BA2ED2.7080807@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>	<45B7818F.6020805@zytor.com>	<Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45B78836.5080508@zytor.com>	<Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45B78C55.2030204@zytor.com> <ep83m2$mts$1@sea.gmane.org>	<45B8E551.9020808@zytor.com> <7vireuxbel.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 17:40:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAU7S-0005KN-EH
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 17:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbXAZQkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 11:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030709AbXAZQkB
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 11:40:01 -0500
Received: from terminus.zytor.com ([192.83.249.54]:33287 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030590AbXAZQkA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 11:40:00 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0QGdkpa012789
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 26 Jan 2007 08:39:47 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <7vireuxbel.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV 0.88.7/2493/Fri Jan 26 04:00:46 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.8 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_12_24,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37872>

Junio C Hamano wrote:
> "H. Peter Anvin" <hpa@zytor.com> writes:
> 
>> For heaven's sake, in computer science we can *NEVER* use the same
>> feature for *MORE THAN ONE THING*.  If it doesn't work format-wise
>> that's fine, but "it's only supposed to be used by dumb transports" is
>> ridiculous.
> 
> Hmmmm... I am lost here....
> 

Jakub and Johannes seems to have been arguing that "info/refs is for 
dumb transports, therefore it cannot be used for any other purpose."  I 
find this argument utterly bizarre, since in general, in computer 
science, you try to be multipurpose whenever practical.

	-hpa
