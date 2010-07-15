From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] gitmodules.5: url can be a relative path
Date: Thu, 15 Jul 2010 13:13:12 +0300
Message-ID: <4C3EDF38.4060003@panasas.com>
References: <4C3DD7EF.6010805@panasas.com> <alpine.DEB.2.00.1007150745340.13735@perkele.intern.softwolves.pp.se> <20100715074155.GA22244@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Lars Hjemli <hjemli@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jul 15 12:13:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZLRR-00006y-Hz
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 12:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757093Ab0GOKNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 06:13:16 -0400
Received: from daytona.panasas.com ([67.152.220.89]:23832 "EHLO
	daytona.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932957Ab0GOKNP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 06:13:15 -0400
Received: from fs2.bhalevy.com ([172.17.33.181]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jul 2010 06:13:14 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
In-Reply-To: <20100715074155.GA22244@burratino>
X-OriginalArrivalTime: 15 Jul 2010 10:13:14.0350 (UTC) FILETIME=[561F80E0:01CB2406]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151071>

On 07/15/2010 10:41 AM, Jonathan Nieder wrote:
> There is already excellent documentation for this facility in
> git-submodule.1, but it is not so discoverable.
> 
> Relative paths in .gitmodules can be useful for serving the
> same repository over multiple protocols, for example.
> Thanks to Peter for pointing this out.
> 

You guys rock. It's exactly what the doctor ordered

Thanks
Boaz
