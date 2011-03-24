From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Sharing a massive distributed merge
Date: Wed, 23 Mar 2011 21:03:40 -0600
Message-ID: <4D8AB48C.9080302@workspacewhiz.com>
References: <4D8119BE.2090208@workspacewhiz.com> <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com> <20110317063816.GD11931@sigill.intra.peff.net> <AANLkTikdXCo_3hGZSaW3+9x6gQ2_B3A=scWN-f3gMSY4@mail.gmail.com> <20110317073053.GI11931@sigill.intra.peff.net> <20110318054934.GA7547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 24 04:03:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2apw-0000AF-Df
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 04:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611Ab1CXDDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 23:03:42 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:34088 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab1CXDDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 23:03:41 -0400
Received: (qmail 6405 invoked by uid 399); 23 Mar 2011 21:03:40 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 23 Mar 2011 21:03:40 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318054934.GA7547@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169888>

Thank you, everyone, for all the feedback.  It still isn't clear to me 
how we can only resolve part of a merge and easily throw away all the 
other files, but we moved forward by just committing the conflict 
markers and resolving from there.

Josh
