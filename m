From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Differing results between gitk --follow and git log --follow
Date: Thu, 07 Oct 2010 13:00:04 -0600
Message-ID: <4CAE18B4.2050700@workspacewhiz.com>
References: <4CAE0DB0.1090608@workspacewhiz.com> <20101007181854.GF18518@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:00:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vi5-0002QX-Kb
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab0JGTAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 15:00:34 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:37057 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab0JGTAG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 15:00:06 -0400
Received: (qmail 3711 invoked by uid 399); 7 Oct 2010 13:00:04 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@69.98.187.106)
  by hsmail.qwknetllc.com with ESMTPAM; 7 Oct 2010 13:00:04 -0600
X-Originating-IP: 69.98.187.106
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101007181854.GF18518@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158432>

  ----- Original Message -----
From: Jeff King
Date: 10/7/2010 12:18 PM
> On Thu, Oct 07, 2010 at 12:13:04PM -0600, Joshua Jensen wrote:
>
>> Is there a way to convince gitk to show me the same bits as git log
>> --follow?
> Sadly, no, not without major surgery to the follow code. See:
>
>    http://article.gmane.org/gmane.comp.version-control.git/147089
Interesting... and way beyond my current capabilities... :(

Thanks for the response.

Josh
