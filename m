From: Ben Harper <ben.harper@rackspace.com>
Subject: Re: life cycle documentation
Date: Mon, 27 Oct 2014 09:52:31 -0500
Message-ID: <544E5C2F.3090800@rackspace.com>
References: <54497DF9.1050501@rackspace.com> <20141024215607.GH312818@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 27 15:45:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XilYS-0002Bi-I0
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 15:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbaJ0Opx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 10:45:53 -0400
Received: from mx2.ord1.rackspace.com ([173.203.4.136]:17038 "EHLO
	mx2.ord1.rackspace.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbaJ0Opw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 10:45:52 -0400
X-SBRS: None
X-SenderGroup: RELAYLIST-US
X-MailFlowPolicy: $RELAYED-US
X-IronPort-AV: E=McAfee;i="5600,1067,7471"; a="400046321"
X-IronPort-AV: E=Sophos;i="5.01,489,1400043600"; 
   d="scan'208";a="400046321"
Received: from ord1exh01.rackspace.corp ([10.12.120.25])
  by mx2.ord1.rackspace.com with ESMTP/TLS/AES128-SHA; 27 Oct 2014 09:45:51 -0500
Received: from x.box (10.1.69.34) by smtpout.rackspace.com (10.12.120.25) with
 Microsoft SMTP Server (TLS) id 14.3.123.3; Mon, 27 Oct 2014 09:45:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141024215607.GH312818@vauxhall.crustytoothpaste.net>
X-Originating-IP: [10.1.69.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2014 04:56 PM, brian m. carlson wrote:
> On Thu, Oct 23, 2014 at 05:15:21PM -0500, Ben Harper wrote:
>> Greetings,
>>
>> I am unable to find any documentation regarding the life cycle regarding the
>> various versions of git.  Is only the current version supported?  What about
>> older minor/major versions?  At what point does a version go EOL? Currently,
>> is only 2.1.2 supported?  I would entertain the thought on creating a
>> RELEASES document if the information is provided.
> The development process is outlined at [0].  Usually there's just one
> supported release (at the moment, 2.1.2), although I have occasionally
> seen releases out of order (from different branches).
>
> Having said that, Git developers try very hard not to break things, so
> many people are fine using an older version, such as the ones their
> distros provide.  It is considered courteous to try the latest version
> before reporting a bug, however.
>
> [0] https://github.com/git/git/blob/master/Documentation/howto/maintain-git.txt
Hey Brian,

Thanks for the clarification.  Someone in IRC mentioned the 
maintain-git.txt file.  I skimmed it and searched for some keywords, but 
was unable to find the information I needed.

Do you feel a RELEASES document is needed or is the maintain-git.txt 
file sufficient?

Ben Harper
OS Deployment Services, RPMDEV
Rackspace Hosting & IUS Community
