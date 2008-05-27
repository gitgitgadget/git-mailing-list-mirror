From: =?UTF-8?B?RmxvcmlhbiBLw7ZiZXJsZQ==?= <FloriansKarten@web.de>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Tue, 27 May 2008 14:11:57 +0200
Message-ID: <483BFA8D.30309@web.de>
References: <20080526044640.GB30245@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 27 14:13:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0y2y-0004BM-NK
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 14:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbYE0MMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 08:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755883AbYE0MME
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 08:12:04 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33641 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827AbYE0MMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 08:12:03 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 39D64DCDD5E5;
	Tue, 27 May 2008 14:12:01 +0200 (CEST)
Received: from [84.150.77.197] (helo=[192.168.1.50])
	by smtp07.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K0y24-0004ox-00; Tue, 27 May 2008 14:12:01 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <20080526044640.GB30245@spearce.org>
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1/f7B9J/wMQGB3tqzANw+WpctOs0kQl53z41Ye8
	YvkmZzwcEls0ZdvyvQDeZDzQ1pQ+/LitS+kjQVXVWUSml/8rXG
	qqOtoUnldY0xY0df/RZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83008>

Hi Shawn

will you convert my last patches (v3) too, or do I have to do it manually?

It would be cool if you would accept or comment my last patches.

Best regards,
Florian

Shawn O. Pearce wrote:
> As of 53a2cc3 the jgit library (a 100% pure Java implementation
> of git) is now licensed under a 3-clause (new-style) BSD license.
> The change was done with a Perl script to rewrite all source code
> headers within the org.spearce.jgit package.  Copyright information
> was updated based upon the output of git-blame.
> 
> The change is here:
> 
> 	git://repo.or.cz/egit/spearce.git bsd
> 
> and is based upon the the thread that I started on this list:
> 
> 	http://article.gmane.org/gmane.comp.version-control.git/81585
> 
> If there are no objections within the next couple of days we'll
> merge it to the main tree.
> 
