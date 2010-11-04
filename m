From: Eric Raible <raible@nextest.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 14:05:56 -0700
Message-ID: <4CD32034.4030104@nextest.com>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr> <4CD2E7B4.3000908@nextest.com> <vpq62wddmc0.fsf@bauges.imag.fr> <20101104181020.GB16431@burratino> <20101104205307.GA8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>, "kevin@sb.org" <kevin@sb.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:06:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE70V-0006Xi-Hq
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019Ab0KDVF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:05:58 -0400
Received: from mail.nextest.com ([12.96.234.114]:53530 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752087Ab0KDVF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:05:57 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 4 Nov 2010 14:05:56 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
In-Reply-To: <20101104205307.GA8911@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160767>

On 11/4/2010 1:53 PM, Yann Dirson wrote:

> Eric Raible suggested:
>> How about:
>>
>> #  e [<commit>], edit [<commit>] = use commit (if present) but pause to amend
> 
> Other commands do not mention commit (or other things) as a synopsis would.
> What about:
> 
> #  e, edit = use commit (if specified) but pause to amend/examine/test
> .

I like that color better.
